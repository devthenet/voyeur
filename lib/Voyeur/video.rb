module Voyeur
  class Video
    attr_reader :filename
    def initialize(options)
      @filename = options[:filename]
    end

    def convert(options)
      converter = Voyeur::Converter.create(format: options[:to])
      converter.convert(video: self,
                        output_filename: options[:output_filename],
                        output_path: options[:output_path])
    end

    def convert_to_html5(options = nil)
      [:mp4, :ogv, :webm].each do |f|
        options_hash = {to: f}
        options_hash.merge!(options) if options
        convert(options_hash)
      end
    end
  end
end
