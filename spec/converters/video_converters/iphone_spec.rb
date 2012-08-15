require 'spec_helper'

describe Voyeur::Iphone do
  let(:converter) { Voyeur::Converter.create(format: :iphone) }
  let(:media) { Voyeur::Media.new(filename: valid_mpeg_file_path) }

  it "uses the correct factory" do
    converter.class.to_s.should == "Voyeur::Iphone"
  end

  it "default convert string" do
    converter.convert_options.should == "-s 320x240 -r 30000/1001 -b 200k -bt 240k -vcodec libx264 -vpre ipod320 -acodec libfaac -ac 2 -ar 48000 -ab 192k"
  end

  context "A valid Media" do
    after :each do
      File.delete(valid_mpeg_file_path.gsub(/mpeg/, "mp4")) if File.exists?(valid_mpeg_file_path.gsub(/mpeg/, "mp4"))
    end

    context "#convert_options" do
      it "names the media correctly" do
        converter.convert(media: media)
        output_file = valid_mpeg_file_path.gsub(/mpeg/, "mp4")
        converter.output_media.filename.should == output_file
      end

      it "returns a media" do
        converter.convert(media: media)
        converter.input_media.should == media
      end

      context "real media" do
        it "returns conversion status indicating success" do
          result = converter.convert(media: media)
          result[:status].should == 0
          result[:media].should == converter.output_media
        end

        it "allows them to name the media" do
          result = converter.convert(media: media)
          result[:status].should == 0
          result[:media].should == converter.output_media
        end
      end
    end
  end

  context "An invalid Media" do
    let(:converter) { Voyeur::Converter.create(format: :iphone) }
    let(:media) { Voyeur::Media.new(filename: 'test_media.mpeg') }

    context "File does not exist" do
      it "returns conversion status indicating failure" do
        result = converter.convert(media: media)
        result[:status].should == 1
        result[:media].should == converter.output_media
        result[:error_message].should match(/test_media.mpeg: No such file or directory/)
        result[:stderr].nil?.should == false
      end
    end
  end
end
