require 'spec_helper'

describe SuperVideo::VideoConverter do
  
  context "mp4" do
    before :each do
      @converter = SuperVideo::VideoConverter.create(format: :mp4)
      @video = SuperVideo::Video.new(filename: 'test_video.mpeg')
    end

    it "should use the correct factory" do
      @converter.class.to_s.should == "SuperVideo::Mp4Converter"
      #converter.input_file_name.should == video.input_filename
    end

    context "#convert_options" do
      it "default convert string" do
        @converter.convert_options.should == "-i test.mpeg -b 1500k -vcodec libx264 -vpre slow -vpre baseline -g 30 test.mp4"
      end

      it "should name the video correctly" do
        pending
        @converter.output_file_name.should == "test_video.mp4"
      end
      it "should return a video" do
        pending
        @converter.input_video.should == video
      end
      it "should return conversion status" do
        pending
        result = @converter.convert(video: video)
        result[:status].should == :success
      end
    end
  end

  context "OGV" do
    before :each do
      @converter = SuperVideo::VideoConverter.create(format: :ogv)
      @video = SuperVideo::Video.new(filename: 'test_video.ogv')
    end
    it "should use the correct factory" do
      @converter.class.to_s.should == "SuperVideo::OgvConverter"
      #converter.input_file_name.should == video.input_filename #erm??
    end

    context "#convert_options" do
      it "default convert string" do
        @converter.convert_options.should == "-b 1500k -vcodec libtheora -acodec libvorbis -ab 160000 -g 30 test.ogv"
      end

      it "should name the video correctly" do
        pending
        @converter.output_file_name.should == "test_video.mp4"
      end
      it "should return a video" do
        pending
        @converter.input_video.should == video
      end
      it "should return conversion status" do
        pending
        result = @converter.convert(video: video)
        result[:status].should == :success
      end
    end
  end
end
