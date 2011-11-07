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
      
      output_video = Video.new(filename: self.output_file_name(video.filename))
      `ffmpeg -i #{video.filename} #{self.convert_options} #{output_video.filename} `
      return {status: :sucess, video: output_video}
    end
    
    def output_file_name(input_file_name)
      input_file_name.split['.'].first + self.file_extension
    end
  end
end
