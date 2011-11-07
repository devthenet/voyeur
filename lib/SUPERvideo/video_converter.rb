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
        when :webm
          WebmConverter.new
      end
    end

    def convert(options)
      video = options[:video]
      raise "Please specify a video to convert!" if video.nil?
      `ffmpeg -i #{video.filename} #{self.convert_option}`
    end
  end
end
