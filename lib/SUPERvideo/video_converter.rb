module SuperVideo
  class VideoConverter
    attr_accessor :input_video
    attr_reader :output_video

    def self.create(options)
      constant = SuperVideo
      klass = "#{options[:format].capitalize}Converter"
      klass = constant.const_get(klass)
      klass.new
    end

    def convert(options)
      begin
        @input_video = options[:video]
        raise SuperVideo::Exceptions::NoVideoPresent unless @input_video

        @output_video = Video.new(filename: self.output_file_name(@input_video.filename))
        `ffmpeg -i #{@input_video.filename} #{self.convert_options} #{@output_video.filename}`
        return {status: :success, video: @output_video}
      rescue SuperVideo::Exceptions::NoVideoPresent
        warn "There was no video attached"
      end
    end

    def output_file_name(input_file_name)
      input_file_name.split('.').first + "." + self.file_extension
    end
  end
end
