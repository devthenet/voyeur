require "Voyeur/version"
require "Voyeur/media"
require "Voyeur/exceptions"
require "Voyeur/converter"
require "Voyeur/video_converters/ogv"
require "Voyeur/video_converters/mp4"
require "Voyeur/video_converters/webm"
require "Voyeur/video_converters/iphone"
require "Voyeur/audio_converters/aac"
require "Voyeur/audio_converters/ogg"
require "Voyeur/media_time"
require 'open4'

module Voyeur
  OPEN4 = RUBY_PLATFORM =~ /java/ ? IO : Open4
end
