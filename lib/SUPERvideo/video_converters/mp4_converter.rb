module SuperVideo
  class Mp4Converter < VideoConverter
    
    def file_extension
      "mp4"
    end
    
    def convert_options
      "-i test.mpeg -b 1500k -vcodec libx264 -vpre slow -vpre baseline -g 30 test.mp4"
    end
  end

end
