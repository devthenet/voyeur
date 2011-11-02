module SuperVideo
  class VideoConverter
    def self.create(options)
      format = options[:format]
      case format
        when :ogv
        debugger
          OgvConverter.new
        when :mp4
          Mp4Converter.new
      end
    end

    def convert
      `ffmpeg #{self.argument_list}`
    end

  end
end
