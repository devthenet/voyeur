module SuperVideo
  class OgvConverter < VideoConverter
    def file_extension
      "ogv"
    end
    
    def convert_options
      "-b 1500k -vcodec libtheora -acodec libvorbis -ab 160000 -g 30"
    end
  end
end
