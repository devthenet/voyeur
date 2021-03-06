module Voyeur
  class Webm < Converter

    def file_extension
      "webm"
    end

    def convert_options
      "-b 1500k -vcodec libvpx -acodec libvorbis -ab 160000 -f webm -g 30"
    end
  end
end
