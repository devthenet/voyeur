module Voyeur
  class Aac < Converter

    def file_extension
      "aac"
    end

    def convert_options
      "-acodec libfaac -ac 2 -ar 44100 -ab 128k"
    end
  end
end
