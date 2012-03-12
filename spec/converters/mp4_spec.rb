require 'spec_helper'

describe Voyeur::Mp4 do
  before :each do
    @converter = Voyeur::Converter.create(format: :mp4)
    @video = Voyeur::Media.new(filename: valid_mpeg_file_path)
  end

  it "should use the correct factory" do
    @converter.class.to_s.should == "Voyeur::Mp4"
  end

  it "default convert string" do
    @converter.convert_options.should == "-b 1500k -vcodec libx264 -g 30"
  end

  context "A valid Video" do
    after :each do
      File.delete(valid_mpeg_file_path.gsub(/mpeg/, "mp4")) if File.exists?(valid_mpeg_file_path.gsub(/mpeg/, "mp4"))
    end

    context "#convert_options" do
      it "should name the video correctly" do
        @converter.convert(media: @video)
        output_file = valid_mpeg_file_path.gsub(/mpeg/, "mp4")
        @converter.output_media.filename.should == output_file
      end

      it "should return a video" do
        @converter.convert(media: @video)
        @converter.input_media.should == @video
      end

      context "real video" do
        it "should return conversion status indicating success" do
          result = @converter.convert(media: @video)
          result[:status].should == 0
          result[:media].should == @converter.output_media
        end

        it "should allow them to name the video" do
          result = @converter.convert(media: @video)
          result[:status].should == 0
          result[:media].should == @converter.output_media
        end
      end
    end
  end

  context "An invalid Video" do
    before :each do
      @converter = Voyeur::Converter.create(format: :mp4)
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
