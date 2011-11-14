module Voyeur
  class Video
    attr_reader :filename
    def initialize(options)
      @filename = options[:filename]
    end

    def convert(options)
      format = options[:to]
      if format.is_a? Array
        format.each do |f|
          converter = Voyeur::VideoConverter.create(format: f)
          converter.convert
        end
      else
        converter = Voyeur::VideoConverter.create(format: format)
        converter.convert
      end
    end
  end
end
