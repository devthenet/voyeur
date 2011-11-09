require 'spec_helper'

describe Voyeur::Mp4Converter do
  context "A valid Video" do
    before :each do
      @converter = Voyeur::VideoConverter.create(format: :mp4)
      @video = Voyeur::Video.new(filename: 'test_video.mpeg')
    end
    it "should use the correct factory" do
      @converter.class.to_s.should == "Voyeur::Mp4Converter"
    end

    context "#convert_options" do
      it "default convert string" do
        @converter.convert_options.should == "-b 1500k -vcodec libx264 -vpre slow -vpre baseline -g 30"
      end
      it "should name the video correctly" do
        @converter.convert(video: @video)
        @converter.output_video.filename.should == "test_video.mp4"
      end
      it "should return a video" do
        @converter.convert(video: @video)
        @converter.input_video.should == @video
      end
      it "should return conversion status indicating success" do
        pending "implement this test with a valid real video!"
        result = @converter.convert(video: @video)
        result[:status].should == 0
        result[:video].should == @converter.output_video
      end
      it "should return stdout" do
        pending "implement this test with a valid real video"
        result = @converter.convert(video: @video)
        result[:stdout].should == ""
      end
    end
  end

  context "An invalid Video" do
    before :each do
      @converter = Voyeur::VideoConverter.create(format: :mp4)
      @video = Voyeur::Video.new(filename: 'test_video.mpeg')
    end
    context "File does not exist" do
      it "should return conversion status indicating failure" do
        result = @converter.convert(video: @video)
        result[:status].should == 1
        result[:video].should == @converter.output_video
        result[:error_message].match(/test_video.mpeg: No such file or directory/).should_not == nil
        result[:stderr].nil?.should == false
      end
    end

  end
end
