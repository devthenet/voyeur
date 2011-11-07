require "SUPERvideo/version"
require "SUPERvideo/video"
require "SUPERvideo/video_converter"
require "SUPERvideo/video_converters/ogv_converter"
require "SUPERvideo/video_converters/mp4_converter"
require "SUPERvideo/video_converters/webm_converter"

module SuperVideo
  attr_accessor :bitrate
end
