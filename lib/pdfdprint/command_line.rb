require 'optparse'

module PDFDirectPrint
  # Processes command line interactions from user
  class CommandLine
    attr_reader :options

    def initialize
      @options = { format: 'A4', port: 9100, resolution: 300, tray: 0 }
    end

    def parse_options
      OptionParser.new do |opts|
        opts.banner = 'Usage: pdfprint [options] [filename|directory]'
        opts.on('-f', '--format=FORMAT', 'Paper format (default: A4)') do |format|
          options[:format] = format
        end
        opts.on('-m', '--move=DIRECTORY', 'Move PDF file to DIRECTORY after printing') do |move|
          options[:move] = move
        end
        opts.on('-o', '--port=PORT', 'Printer TCP port (default: 9100)') do |port|
          options[:port] = port
        end
        opts.on('-p', '--printer=PRINTER', 'Printer hostname or IP address') do |printer|
          options[:printer] = printer
        end
        opts.on('-r', '--resolution=RESOLUTION', 'Print resolution in dpi (default: 300)') do |resolution|
          options[:resolution] = resolution
        end
        opts.on('-t', '--tray=TRAY', 'Paper tray number (default: 0)') do |tray|
          options[:tray] = tray
        end
      end.parse!
    end

    def validate_options
      if options.key?(:printer)
        puts "[INFO]: Using printer #{options[:printer]} on port #{options[:port]}"
      else
        puts 'Please specify a printer to print to using the -p option'
        exit 1
      end
      if ARGV[0].nil?
        puts 'Please specify a directory or PDF file'
        exit 1
      end
      return if File.exist?(ARGV[0])

      puts "[ERROR]: File or directory #{ARGV[0]} does not exist"
      exit 1
    end

    def process_directory
      puts "[INFO]: Processing directory #{ARGV[0]}"
      raw_printer = RawPrint.new(options)
      pdf_files_from_dir(ARGV[0]).each do |pdf_file|
        file_w_dir = File.join(ARGV[0], pdf_file)
        puts "[INFO]: Processing file #{pdf_file}"
        if raw_printer.print(file_w_dir)
          puts "[INFO]: Succesfully printed file #{pdf_file}"
          options.key?(:move) && move_file_to_dir(file_w_dir, options[:move])
        else
          puts "[ERROR]: Failed to print due to #{raw_printer.error_message}"
        end
        sleep 1
      end
    end

    def process_file
      puts "[INFO]: Processing file #{ARGV[0]}"
      pdf = RawPrint.new(options)
      if pdf.print(ARGV[0])
        puts "[INFO]: Succesfully printed file #{ARGV[0]}"
        options.key?(:move) && move_file_to_dir(ARGV[0], options[:move])
      else
        puts "[ERROR]: Failed to print due to #{pdf.error_message}"
      end
    end

    private

    def pdf_files_from_dir(dir)
      pdf_files = []
      Dir.glob(['*.pdf', '*.PDF'], base: dir) do |pdf_file|
        pdf_files << pdf_file
      end
      pdf_files.sort!
    end

    def move_file_to_dir(file, dir)
      unless File.directory?(dir) || File.writable?(file)
        puts "[WARNING]: Move to directory #{dir} does not exist or is not writable"
        return
      end
      puts "[INFO]: Moving file #{file} to directory #{dir}"
      FileUtils.mv(file, "#{dir}/#{File.basename(file)}")
    end
  end
end
