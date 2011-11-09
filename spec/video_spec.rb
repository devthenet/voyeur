require 'spec_helper'

describe Voyeur::Video do
  it 'should create a new video object from a filename' do
    video_input_name = 'test_file.mpeg'
    video = Voyeur::Video.new filename: video_input_name
    video.filename.should == video_input_name
  end

  it "should convert a video to ogv" do
    pending "Video.new( filename: 'filename.mpeg').convert to: :ogv"
  end

  it "should convert a video to mp4" do
    test_video_path = File.expand_path(File.dirname(__FILE__))
    test_video_file_name = "test.mpeg"
    pending "Video.new( filename: 'filename.mpeg').convert to: :mp4"
  end

  it "should convert a video to webm" do
    pending "Video.new( filename: 'filename.mpeg').convert to: :webm )"
  end

  it "should convert a video to all HTML5 video formats" do
    pending "Video.new( filename: 'filename.mpeg').convert to: :html5"
  end

  it "should allow the user to specify a path" do
    pending "Video.new( filename: 'filename.mpeg').convert to: ogv, output_base_filename: icecream.ogv"
  end

end
