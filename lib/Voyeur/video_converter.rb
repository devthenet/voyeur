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

      begin
        @output_video = Video.new(filename: self.output_file_name(@input_video.filename))
        `ffmpeg -i #{@input_video.filename} #{self.convert_options} #{@output_video.filename}`
        return {status: :success, video: @output_video}
      rescue Voyeur::Exceptions::NoVideoPresent
        warn "There was no video attached"
      end

      # @output_video = Video.new(filename: self.output_file_name(@input_video.filename))
      # self.call_external_converter
    end

    def output_file_name(input_file_name)
      input_file_name.gsub(/\.[\w]+$/, "." + self.file_extension )
    end

    protected
  end
end
