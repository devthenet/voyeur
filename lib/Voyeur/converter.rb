module Voyeur
  class Converter
    attr_accessor :input_video
    attr_reader :output_video
    attr_reader :status

    def self.create(options)
      constant = Voyeur
      klass = options[:format].to_s.capitalize
      raise Voyeur::Exceptions::InvalidFormat unless constant.const_defined? klass
      klass = constant.const_get klass
      klass.new
    end

    def convert(options)
      @input_video = options[:video]
      raise Voyeur::Exceptions::NoVideoPresent unless @input_video
      output_filename = self.output_path( options[:output_path] )
      @output_video = Video.new(:filename => output_file(options[:output_path], options[:output_filename]))
      self.call_external_converter
    end

    protected

    def output_file(path, filename)
      "#{output_path(path)}/#{output_filename(filename)}"
    end

    def output_path(output_path = nil)
      raise Voyeur::Exceptions::InvalidLocation if output_path && !File.directory?(output_path)
      output_path ? output_path : File.dirname(@input_video.filename)
    end

    def output_filename(input_filename = nil)
      filename = input_filename.nil? ? @input_video.filename : input_filename
      File.basename(filename, '.*') + ".#{self.file_extension}"
    end

    def call_external_converter
      command = "ffmpeg -i #{@input_video.filename} #{self.convert_options} #{@output_video.filename}"
      out, err = ""

      status = Open4::popen4(command) do |pid, stdin, stdout, stderr|
        out = stdout.read.strip
        err = stderr.read.strip
      end

      error_message = err.split('\n').last

      @status = { :status => status.exitstatus, :stdout => out, :stderr => err,
        :error_message => error_message, :video => @output_video }
      return @status
    end
  end
end
