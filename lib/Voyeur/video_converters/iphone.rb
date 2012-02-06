#H.264 for iphone
module Voyeur
  class Iphone < Converter

    def file_extension
      "mp4"
    end

    def convert_options
      "-s 320x240 -r 30000/1001 -b 200k -bt 240k -vcodec libx264 -vpre ipod320 -acodec libfaac -ac 2 -ar 48000 -ab 192k"
    end
  end

end