module Voyeur
  class MediaTime
    attr_accessor :raw_time
    attr_accessor :hours, :minutes, :seconds
    
    def initialize(raw_time)
      @hours, @minutes, @seconds = raw_time.split(":")
      @hours = @hours.to_i
      @minutes = @minutes.to_i
      @seconds = @seconds.to_i
    end
    
    def to_seconds
      @seconds.to_i + (@minutes.to_i * 60) + (@hours.to_i * 60 *60)
    end
    
  end
end
