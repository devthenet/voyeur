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
      debugger
      `ffmpeg #{self.convert_options}`
    end
  end
end
