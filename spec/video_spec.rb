require 'spec_helper'

describe Voyeur::Video do
  it 'should create a new video object from a filename' do
    video_input_name = 'test_file.mpeg'
    video = Voyeur::Video.new filename: video_input_name
    video.filename.should == video_input_name
  end

  it "should convert a video to ogv" do
    Voyeur::Video.new( filename: valid_mpeg_file_path ).convert(to: :ogv)
    File.exist?(valid_mpeg_file_path.gsub(/mpeg/, "ogv")).should be_true
    File.delete(valid_mpeg_file_path.gsub(/mpeg/, "ogv"))
  end

  it "should convert a video to mp4" do
    Voyeur::Video.new( filename: valid_mpeg_file_path ).convert(to: :mp4)
    File.exist?(valid_mpeg_file_path.gsub(/mpeg/, "mp4")).should be_true
    File.delete(valid_mpeg_file_path.gsub(/mpeg/, "mp4"))
  end

  it "should convert a video to webm" do
    Voyeur::Video.new( filename: valid_mpeg_file_path ).convert(to: :webm)
    File.exist?(valid_mpeg_file_path.gsub(/mpeg/, "webm")).should be_true
    File.delete(valid_mpeg_file_path.gsub(/mpeg/, "webm"))
  end

  it "should convert a video to all HTML5 video formats" do
    Voyeur::Video.new( filename: valid_mpeg_file_path ).convert_to_html5
    File.exists?(valid_mpeg_file_path.gsub(/mpeg/, "mp4")).should be_true
    File.delete(valid_mpeg_file_path.gsub(/mpeg/, "mp4"))
    File.exists?(valid_mpeg_file_path.gsub(/mpeg/, "ogv")).should be_true
    File.delete(valid_mpeg_file_path.gsub(/mpeg/, "ogv"))
    File.exists?(valid_mpeg_file_path.gsub(/mpeg/, "webm")).should be_true
    File.delete(valid_mpeg_file_path.gsub(/mpeg/, "webm"))
  end

  it "should allow the user to specify a path" do
    pending "Video.new( filename: 'filename.mpeg').convert to: ogv, output_base_filename: icecream.ogv"
  end

end
