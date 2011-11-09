describe Voyeur::Mp4Converter do
  context "New Video" do
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

      it "should raise an exception if no video is passed" do
        @video = nil
        @converter.convert(video: @video).should raise_error
      end

      it "should name the video correctly" do
        @converter.convert(video: @video)
        @converter.output_video.filename.should == "test_video.mp4"
      end
      it "should return a video" do
        @converter.convert(video: @video)
        @converter.input_video.should == @video
      end
      it "should return conversion status" do
        result = @converter.convert(video: @video)
        result[:status].should == :success
        result[:video].should == @converter.output_video
      end
    end
  end
end
