require 'spec_helper'

describe Voyeur::Iphone do
  before :each do
    @converter = Voyeur::Converter.create(format: :iphone)
    @video = Voyeur::Video.new(filename: valid_mpeg_file_path)
  end

  it "should use the correct factory" do
    @converter.class.to_s.should == "Voyeur::Iphone"
  end

  it "default convert string" do
    @converter.convert_options.should == "-s 320x240 -r 30000/1001 -b 200k -bt 240k -vcodec libx264 -vpre ipod320 -acodec libfaac -ac 2 -ar 48000 -ab 192k"
  end

  context "A valid Video" do
    after :each do
      File.delete(valid_mpeg_file_path.gsub(/mpeg/, "mp4")) if File.exists?(valid_mpeg_file_path.gsub(/mpeg/, "mp4"))
    end

    context "#convert_options" do
      it "should name the video correctly" do
        @converter.convert(video: @video)
        output_file = valid_mpeg_file_path.gsub(/mpeg/, "mp4")
        @converter.output_video.filename.should == output_file
      end

      it "should return a video" do
        @converter.convert(video: @video)
        @converter.input_video.should == @video
      end

      context "real video" do
        it "should return conversion status indicating success" do
          result = @converter.convert(video: @video)
          result[:status].should == 0
          result[:video].should == @converter.output_video
        end

        it "should allow them to name the video" do
          result = @converter.convert(video: @video)
          result[:status].should == 0
          result[:video].should == @converter.output_video
        end
      end
    end
  end

  context "An invalid Video" do
    before :each do
      @converter = Voyeur::Converter.create(format: :mp4)
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
