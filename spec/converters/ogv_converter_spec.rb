describe SuperVideo::OgvConverter do
  context "New Video" do
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
        @converter.convert_options.should == "-b 1500k -vcodec libtheora -acodec libvorbis -ab 160000 -g 30"
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
