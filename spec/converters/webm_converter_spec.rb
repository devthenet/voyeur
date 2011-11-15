require 'spec_helper'

describe Voyeur::WebmConverter do
  context "New Video" do
    before :each do
      @converter = Voyeur::VideoConverter.create(format: :webm)
      @video = Voyeur::Video.new(filename: 'test_video.webm')
    end

    it "should use the correct factory" do
      @converter.class.to_s.should == "Voyeur::WebmConverter"
    end

    context "#convert_options" do
      it "default convert string" do
        @converter.convert_options.should == "-b 1500k -vcodec libvpx -acodec libvorbis -ab 160000 -f webm -g 30"
      end

      it "should raise an exception if no video is passed" do
        @video = nil
        -> { @converter.convert(video: @video) }.should raise_error
      end

      it "should name the video correctly" do
        @converter.convert(video: @video)
        @converter.output_video.filename.should == "test_video.webm"
      end

      it "should return a video" do
        @converter.convert(video: @video)
        @converter.input_video.should == @video
      end
    end
  end

  context "An invalid Video" do
    before :each do
      @converter = Voyeur::VideoConverter.create(format: :webm)
      @video = Voyeur::Video.new(filename: 'test_video.mpeg')
    end

    context "File does not exist" do
      it "should return conversion status indicating failure" do
        result = @converter.convert(video: @video)
        result[:status].should == 1
        result[:video].should == @converter.output_video
        result[:error_message].should match(/test_video.mpeg: No such file or directory/)
        result[:stderr].nil?.should == false
      end
    end
  end

end
