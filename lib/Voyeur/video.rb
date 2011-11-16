module Voyeur
  class Video
    attr_reader :filename
    def initialize(options)
      @filename = options[:filename]
    end

    def convert(options)
      format = options[:to]
      converter = Voyeur::VideoConverter.create(format: format)
      converter.convert(video: self)
    end

    def convert_to_html5
      [:mp4, :ogv, :webm].each do |f|
        convert(to: f)
      end
    end
  end
end
