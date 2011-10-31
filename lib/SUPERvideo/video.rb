module SuperVideo
  class Video
    attr_reader :filename
    def initialize(options)
      @filename = options[:filename]
    end    
  end
end
