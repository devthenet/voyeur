require 'spec_helper'

describe Voyeur::Media do
  it 'should create a new video object from a filename' do
    video_input_name = 'test_file.mpeg'
    video = Voyeur::Media.new filename: video_input_name
    video.filename.should == video_input_name
  end
  
  it 'should get duration of a media object from a filename' do
    video = Voyeur::Media.new( filename: valid_mpeg_file_path )
    video.raw_duration.should_not be_nil
    video.raw_duration.should_not == ''
  end

  it "should convert a video to ogv" do
    Voyeur::Media.new( filename: valid_mpeg_file_path ).convert(to: :ogv)
    ogv_file = valid_mpeg_file_path.gsub(/mpeg/, "ogv")
    File.should exist(ogv_file)
    File.delete(ogv_file)
  end

  it "should convert a video to mp4" do
    Voyeur::Media.new( filename: valid_mpeg_file_path ).convert(to: :mp4)
    mp4_file = valid_mpeg_file_path.gsub(/mpeg/, "mp4")
    File.should exist(mp4_file)
    File.delete(mp4_file)
  end

  it "should convert a video to webm" do
    Voyeur::Media.new( filename: valid_mpeg_file_path ).convert(to: :webm)
    webm_file = valid_mpeg_file_path.gsub(/mpeg/, "webm")
    File.should exist(webm_file)
    File.delete(webm_file)
  end

  it "should convert a video to all HTML5 video formats" do
    Voyeur::Media.new( filename: valid_mpeg_file_path ).convert_to_html5

    mp4_file = valid_mpeg_file_path.gsub(/mpeg/, "mp4")
    File.should exist(mp4_file)
    File.delete(mp4_file)

    ogv_file = valid_mpeg_file_path.gsub(/mpeg/, "ogv")
    File.should exist(ogv_file)
    File.delete(ogv_file)

    webm_path = valid_mpeg_file_path.gsub(/mpeg/, "webm")
    File.should exist(webm_path)
    File.delete(webm_path)
  end

  it "should allow the user to name the video" do
    Voyeur::Media.new( filename: valid_mpeg_file_path ).
      convert(to: :webm, output_filename: "sexypants")
    webm_file = "#{fixture_file_path}/sexypants.webm"
    File.should exist(webm_file)
    File.delete(webm_file)
  end

  it "should allow the user to specify a video path" do
    output_path = "#{fixture_file_path}/converted"
    Voyeur::Media.new( filename: valid_mpeg_file_path ).
      convert(to: :ogv, output_path: output_path)
    test_file = "#{output_path}/test.ogv"
    File.should exist(test_file)
    File.delete(test_file)
  end

  it "should allow a user to specify a video path and filename" do
    output_path = "#{fixture_file_path}/converted"
    Voyeur::Media.new( filename: valid_mpeg_file_path ).
      convert(to: :ogv, output_path: output_path, output_filename: "supersexypants")
    supersexypants_file = "#{output_path}/supersexypants.ogv"
    File.should exist(supersexypants_file)
    File.delete(supersexypants_file)
  end

  it "should allow user to convert given to a format given a class name" do
    Voyeur::Media.new( filename: valid_mpeg_file_path ).convert(to: Voyeur::Webm)
    webm_file = valid_mpeg_file_path.gsub(/mpeg/, "webm")
    File.should exist(webm_file).should be_true
    File.delete(webm_file)
  end

  it "should allow a user to specify a video path and filename when converting all formats" do
    output_path = "#{fixture_file_path}/converted"
    Voyeur::Media.new( filename: valid_mpeg_file_path ).
      convert_to_html5(output_path: output_path, output_filename: "supersexypants")
    ogv_file = "#{output_path}/supersexypants.ogv"
    File.should exist(ogv_file)
    File.delete(ogv_file)

    mp4_file = "#{output_path}/supersexypants.mp4"
    File.should exist(mp4_file)
    File.delete(mp4_file)

    webm_file = "#{output_path}/supersexypants.webm"
    File.should exist(webm_file)
    File.delete(webm_file)
  end

  it "should not allow the user to specify a folder that doesn't exist" do
    output_path = "#{fixture_file_path}/icecream"
    -> { Voyeur::Media.new( filename: valid_mpeg_file_path ).
      convert(to: :ogv, output_path: output_path) }.should raise_error Voyeur::Exceptions::InvalidLocation
  end
  
  context "when convert is called with a block" do
    it "should update the progress with time" do
      output = ''
      Voyeur::Media.new( filename: valid_mpeg_file_path ).convert(to: :ogv) do |time|
        output += time
      end
      output.should_not == ''
      output.length.should > 0
    end
  end
end
