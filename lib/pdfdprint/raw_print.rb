require 'fileutils'
require 'socket'

module PDFDirectPrint
  # Raw network printing using TCP port 9100 of network-enabled printer
  class RawPrint
    attr_reader :error_message

    def initialize(options)
      @options = options
      @pjl = setup_pjl
    end

    def print(file)
      s = TCPSocket.open(@options[:printer], @options[:port])
      @pjl.each do |_key, command|
        s.syswrite(command)
      end
      File.open(file, 'rb') do |f|
        f.binmode
        s.syswrite(f.read)
      end
      s.syswrite("#{27.chr}%-12345X")
      s.flush
      s.close
      true
    rescue StandardError => e
      @error_message = e.message
      false
    end

    private

    def setup_pjl
      pjl = {}
      pjl['escapeseq']  = "#{27.chr}%-12345X\@PJL#{13.chr}#{10.chr}"
      pjl['input1']     = "\@PJL SET MEDIASOURCE = TRAY#{@options[:tray]}#{13.chr}#{10.chr}"
      pjl['input2']     = "\@PJL SET RESOLUTION = #{@options[:resolution]}#{13.chr}#{10.chr}"
      pjl['input3']     = "\@PJL SET PAPER = #{@options[:format]}#{13.chr}#{10.chr}"
      pjl['lang']       = "\@PJL ENTER LANGUAGE = PDF#{13.chr}#{10.chr}"
      pjl
    end
  end
end
