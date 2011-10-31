module SuperVideo
  class Video
    attr_reader :filename
    def initialize(options)
      @filename = options[:filename]
    end    

    def convert(options)
      format = options[:to]
      converter = SuperVideo::VideoConverter.new(format: format)
      converter.convert
    end
  end
end
