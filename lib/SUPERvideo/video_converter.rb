module SuperVideo
  class VideoConverter
    attr_accessor :bitrate
    def self.create(options)
      format = options[:format]
      case format
        when :ogv
          OgvConverter.new
        when :mp4
          Mp4Converter.new
      end
    end

    def convert(pew)
      `ffmpeg #{self.convert_options(pew)}`
    end
  end
end
