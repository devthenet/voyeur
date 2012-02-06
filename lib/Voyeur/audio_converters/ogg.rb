module Voyeur
  class Ogg < Converter

    def file_extension
      "ogg"
    end

    def convert_options
      "-strict -2 -acodec vorbis -aq 60"
    end
  end

end