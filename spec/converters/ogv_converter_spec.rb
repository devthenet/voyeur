describe Voyeur::OgvConverter do
  context "New Video" do
    before :each do
      @converter = Voyeur::VideoConverter.create(format: :ogv)
      @video = Voyeur::Video.new(filename: 'test_video.ogv')
    end

    it "should use the correct factory" do
      @converter.class.to_s.should == "Voyeur::OgvConverter"
    end

    context "#convert_options" do
      it "default convert string" do
        @converter.convert_options.should == "-b 1500k -vcodec libtheora -acodec libvorbis -ab 160000 -g 30"
      end

      it "should raise an exception if no video is passed" do
        @video = nil
        @converter.convert(video: @video).should raise_error
      end

      it "should name the video correctly" do
        @converter.convert(video: @video)
        @converter.output_video.filename.should == "test_video.ogv"
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
