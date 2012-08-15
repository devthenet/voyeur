require 'spec_helper'

describe Voyeur::MediaTime do
  context "When passing a valid 0 time string in" do
    let(:raw_time) { "00:00:00.00" }
    let(:media_time) { Voyeur::MediaTime.new(raw_time) }

    it "hours minutes and seconds should be 0" do
      media_time.hours.should == 0
      media_time.minutes.should == 0
      media_time.seconds.should == 0
    end

    it "returns 0 seconds" do
      media_time.to_seconds.should == 0
    end
  end

  context "When passing a a valid 1 minutes long time string in" do
    let(:raw_time) { "00:01:00.00" }
    let(:media_time) { Voyeur::MediaTime.new(raw_time) }

    it "haves minutes as one" do
      media_time.hours.should == 0
      media_time.minutes.should == 1
      media_time.seconds.should == 0
    end

    it "returns 60 seconds" do
      media_time.to_seconds.should == 60
    end
  end

  context "When passing a valid string with 1 hour 10 minute and 20 seconds" do
    let(:raw_time) { "01:10:20.00" }
    let(:media_time) { Voyeur::MediaTime.new(raw_time) }

    it "haves hour as one, minutes as 10 and seconds as 20" do
      media_time.hours.should == 1
      media_time.minutes.should == 10
      media_time.seconds.should == 20
    end

    it "returns 4220 seconds" do
      media_time.to_seconds.should == 4220
    end
  end
end
