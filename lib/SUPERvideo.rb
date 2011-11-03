require "SUPERvideo/version"
require "SUPERvideo/video"
require "SUPERvideo/video_converter"
require "SUPERvideo/video_converters/ogv_converter"
require "SUPERvideo/video_converters/mp4_converter"
module SuperVideo
  attr_accessor :bitrate

  #ffmpeg -i test.mpeg -b 1500k -vcodec libtheora -acodec libvorbis -ab 160000 -g 30 test.ogv


end
