module SuperVideo
  class VideoConverter
    attr_accessor :input_video
    attr_reader :output_video

    def self.create(options)
      format = options[:format]
      case format
      when :mp4
        Mp4Converter.new
      when :ogv
        OgvConverter.new
      when :webm
        WebmConverter.new
      end
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
