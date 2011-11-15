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
  end
end
