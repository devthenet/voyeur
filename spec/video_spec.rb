require 'spec_helper'

describe Voyeur::Media do
  it 'should create a new video object from a filename' do
    video_input_name = 'test_file.mpeg'
    video = Voyeur::Media.new filename: video_input_name
    video.filename.should == video_input_name
  end

  it "should convert a video to ogv" do
    Voyeur::Media.new( filename: valid_mpeg_file_path ).convert(to: :ogv)
    File.exist?(valid_mpeg_file_path.gsub(/mpeg/, "ogv")).should be_true
    File.delete(valid_mpeg_file_path.gsub(/mpeg/, "ogv"))
  end

  it "should convert a video to mp4" do
    Voyeur::Media.new( filename: valid_mpeg_file_path ).convert(to: :mp4)
    File.exist?(valid_mpeg_file_path.gsub(/mpeg/, "mp4")).should be_true
    File.delete(valid_mpeg_file_path.gsub(/mpeg/, "mp4"))
  end

  it "should convert a video to webm" do
    Voyeur::Media.new( filename: valid_mpeg_file_path ).convert(to: :webm)
    File.exist?(valid_mpeg_file_path.gsub(/mpeg/, "webm")).should be_true
    File.delete(valid_mpeg_file_path.gsub(/mpeg/, "webm"))
  end

  it "should convert a video to all HTML5 video formats" do
    Voyeur::Media.new( filename: valid_mpeg_file_path ).convert_to_html5
    File.exists?(valid_mpeg_file_path.gsub(/mpeg/, "mp4")).should be_true
    File.delete(valid_mpeg_file_path.gsub(/mpeg/, "mp4"))
    File.exists?(valid_mpeg_file_path.gsub(/mpeg/, "ogv")).should be_true
    File.delete(valid_mpeg_file_path.gsub(/mpeg/, "ogv"))
    File.exists?(valid_mpeg_file_path.gsub(/mpeg/, "webm")).should be_true
    File.delete(valid_mpeg_file_path.gsub(/mpeg/, "webm"))
  end

  it "should allow the user to name the video" do
    Voyeur::Media.new( filename: valid_mpeg_file_path ).
      convert(to: :webm, output_filename: "sexypants")
    File.exists?("#{fixture_file_path}/sexypants.webm").should be_true
    File.delete("#{fixture_file_path}/sexypants.webm")
  end

  it "should allow the user to specify a video path" do
    output_path = "#{fixture_file_path}/converted"
    Voyeur::Media.new( filename: valid_mpeg_file_path ).
      convert(to: :ogv, output_path: output_path)
    File.exists?("#{output_path}/test.ogv").should be_true
    File.delete("#{output_path}/test.ogv")
  end

  it "should allow a user to specify a video path and filename" do
    output_path = "#{fixture_file_path}/converted"
    Voyeur::Media.new( filename: valid_mpeg_file_path ).
      convert(to: :ogv, output_path: output_path, output_filename: "supersexypants")
    File.exists?("#{output_path}/supersexypants.ogv").should be_true
    File.delete("#{output_path}/supersexypants.ogv")
  end

  it "should allow a user to specify a video path and filename when converting all formats" do
    output_path = "#{fixture_file_path}/converted"
    Voyeur::Media.new( filename: valid_mpeg_file_path ).
      convert_to_html5(output_path: output_path, output_filename: "supersexypants")
    File.exists?("#{output_path}/supersexypants.ogv").should be_true
    File.delete("#{output_path}/supersexypants.ogv")
    File.exists?("#{output_path}/supersexypants.mp4").should be_true
    File.delete("#{output_path}/supersexypants.mp4")
    File.exists?("#{output_path}/supersexypants.webm").should be_true
    File.delete("#{output_path}/supersexypants.webm")
  end

  it "should not allow the user to specify a folder that doesn't exist" do
    output_path = "#{fixture_file_path}/icecream"
    -> { Voyeur::Media.new( filename: valid_mpeg_file_path ).
      convert(to: :ogv, output_path: output_path) }.should raise_error Voyeur::Exceptions::InvalidLocation
  end
end
