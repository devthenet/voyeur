require 'spec_helper'

describe SuperVideo::Video do
  it 'should create a new video object from a filename' do
    video_input_name = 'test_file.mpeg'
    video = SuperVideo::Video.new filename: video_input_name
    video.filename.should == video_input_name
  end
end
