module SuperVideo
  class Mp4Converter < VideoConverter
    def convert_options
      "ffmpeg -i test.mpeg -b 1500k -vcodec libx264 -vpre slow -vpre baseline -g 30 test.mp4"
    end
  end

end
