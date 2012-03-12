require 'spec_helper'

describe Voyeur::Ogv do
  context "New Video" do
    before :each do
      @converter = Voyeur::Converter.create(format: :ogv)
      @video = Voyeur::Media.new(filename: 'test_video.ogv')
    end

    it "should use the correct factory" do
      @converter.class.to_s.should == "Voyeur::Ogv"
    end

    context "#convert_options" do
      it "default convert string" do
        @converter.convert_options.should == "-b 1500k -vcodec libtheora -acodec libvorbis -ab 160000 -g 30"
      end

      it "should raise an exception if no video is passed" do
        @video = nil
        -> { @converter.convert(media: @video) }.should raise_error Voyeur::Exceptions::NoMediaPresent
      end

      it "should return a video" do
        @converter.convert(media: @video)
        @converter.input_media.should == @video
      end
    end
  end

  context "An invalid Video" do
    before :each do
      @converter = Voyeur::Converter.create(format: :ogv)
      @video = Voyeur::Media.new(filename: 'test_video.mpeg')
    end
    context "File does not exist" do
      it "should return conversion status indicating failure" do
        result = @converter.convert(media: @video)
        result[:status].should == 1
        result[:media].should == @converter.output_media
        result[:error_message].should match(/test_video.mpeg: No such file or directory/)
        result[:stderr].nil?.should == false
      end
    end
  end
end
