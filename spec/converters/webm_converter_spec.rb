 describe SuperVideo::WebmConverter do
  context "New Video" do
    before :each do
      @converter = SuperVideo::VideoConverter.create(format: :webm)
      @video = SuperVideo::Video.new(filename: 'test_video.webm')
    end

    it "should use the correct factory" do
      @converter.class.to_s.should == "SuperVideo::WebmConverter"
    end

    context "#convert_options" do
      it "default convert string" do
        @converter.convert_options.should == "-b 1500k -vcodec libvpx -acodec libvorbis -ab 160000 -f webm -g 30"
      end

      it "should raise an exception if no video is passed" do
        @video = nil
        @converter.convert(video: @video).should raise_error
      end

      it "should name the video correctly" do
        @converter.convert(video: @video)
        @converter.output_video.filename.should == "test_video.webm"
      end

      it "should return a video" do
        @converter.convert(video: @video)
        @converter.input_video.should == @video
      end

      it "should return conversion status" do
        pending
        result = @converter.convert(video: video)
        result[:status].should == :success
      end
    end
  end
end
