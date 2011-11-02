require 'spec_helper'

describe SuperVideo::VideoConverter do
  it "should convert a video object to mp4 format" do
    converter = SuperVideo::VideoConverter.create(format: :mp4)
    video = SuperVideo::Video.new(filename: 'test_video.mpeg')
    converter.class.to_s.should == "SuperVideo::Mp4Converter"
    converter.argument_list.should == "-b 1500k -vcodec libx264 -vpre slow -vpre baseline -g 30"
    result = converter.convert(video: video)
    result[:status].should == :success
    converter.input_file_name.should == video.input_filename
    converter.output_file_name.should == "test_video.mp4"
    converter.input_video.should == video
  end

  it "should convert a video object to ogv format" do
    converter = SuperVideo::VideoConverter.create(format: :ogv)
    debugger
    video = SuperVideo::Video.new(filename: 'test_video.ogv')
    converter.class.to_s.should == "SuperVideo::OgvConverter"
    converter.argument_list.should == "-b 1500k -vcodec libtheora -acodec libvorbis -ab 160000 -g 30"
    result = converter.convert(video: video)
    result[:status].should == :success
    converter.input_file_name.should == video.input_filename
    converter.output_file_name.should == "test_video.mp4"
    converter.input_video.should == video
  end
end
