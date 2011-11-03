module SuperVideo
  class OgvConverter < VideoConverter
    def convert_options
      "-b 1500k -vcodec libtheora -acodec libvorbis -ab 160000 -g 30 test.ogv"
    end
  end
end
