require 'pdfdprint/command_line'
require 'pdfdprint/raw_print'
require 'pdfdprint/version'

# PDF Direct Print main module used for name spacing
module PDFDirectPrint
  def self.run
    cl = CommandLine.new
    cl.parse_options
    cl.validate_options

    if File.directory?(ARGV[0])
      cl.process_directory
    elsif File.file?(ARGV[0])
      cl.process_file
    end
  end
end
