require 'spec_helper'

describe Voyeur::Ogg do
  before :each do
    @converter = Voyeur::Converter.create(format: :ogg)
    @audio = Voyeur::Video.new(filename: valid_mpeg_file_path)
  end

  it "should use the correct factory" do
    @converter.class.to_s.should == "Voyeur::Ogg"
  end

  it "default convert string" do
    @converter.convert_options.should == "-strict -2 -acodec vorbis -aq 60"
  end

  context "A valid audio files" do
    after :each do
      File.delete(valid_mpeg_file_path.gsub(/mpeg/, "ogg")) if File.exists?(valid_mpeg_file_path.gsub(/mpeg/, "ogg"))
    end

    context "#convert_options: " do
      it "should name the video correctly" do
        @converter.convert(video: @audio)
        output_file = valid_mpeg_file_path.gsub(/mpeg/, "ogg")
        @converter.output_video.filename.should == output_file
      end

      it "should return an audio file" do
        @converter.convert(video: @audio)
        @converter.input_video.should == @audio
      end

      context "audio file - " do
        it "should return conversion status indicating success" do
          result = @converter.convert(video: @audio)
          result[:status].should == 0
          result[:video].should == @converter.output_video
        end

        it "should allow it to be named" do
          result = @converter.convert(video: @audio)
          result[:status].should == 0
          result[:video].should == @converter.output_video
        end
      end
    end
  end

  context "An invalid audio file" do
    before :each do
      @converter = Voyeur::Converter.create(format: :ogg)
      @audio = Voyeur::Video.new(filename: 'test_video.mpeg')
    end

    it "should return conversion status indicating failure" do
      result = @converter.convert(video: @audio)
      result[:status].should == 1
      result[:video].should == @converter.output_video
      result[:error_message].should match(/test_video.mpeg: No such file or directory/)
      result[:stderr].nil?.should == false
    end
  end
end
