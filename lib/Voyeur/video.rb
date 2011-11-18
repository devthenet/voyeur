module Voyeur
  class Video
    attr_reader :filename
    def initialize(options)
      @filename = options[:filename]
    end

    def convert(options)
      converter = Voyeur::VideoConverter.create(format: options[:to])
      converter.convert(video: self,
                        output_filename: options[:output_filename],
                        output_path: options[:output_path])
    end

    def convert_to_html5
      [:mp4, :ogv, :webm].each { |f| convert(to: f) }
    end
  end
end
