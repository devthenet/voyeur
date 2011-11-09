module Voyeur
  class VideoConverter
    attr_accessor :input_video
    attr_reader :output_video
    attr_reader :status

    def self.create(options)
      constant = Voyeur
      klass = "#{options[:format].capitalize}Converter"
      raise Voyeur::Exceptions::InvalidFormat unless constant.const_defined? klass
      klass = constant.const_get klass
      klass.new
    end

    def convert(options)
      @input_video = options[:video]
      raise Voyeur::Exceptions::NoVideoPresent unless @input_video

      @output_video = Video.new(filename: self.output_file_name(@input_video.filename))
      self.call_external_converter
    end

    def output_file_name(input_file_name)
      input_file_name.split('.').first + "." + self.file_extension
    end

    protected
    def call_external_converter
      command = "ffmpeg -i #{@input_video.filename} #{self.convert_options} #{@output_video.filename}"

      out, err = ""

      status = Open4::popen4(command) do |pid, stdin, stdout, stderr|
        out = stdout.read.strip
        err = stderr.read.strip
      end

      error_message = err.split('\n').last

      @status = { status: status.exitstatus, stdout: out, stderr: err,
                  error_message: error_message, video: @output_video }
      return @status
    end
  end
end
