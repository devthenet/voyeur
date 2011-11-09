require 'spec_helper'

describe Voyeur::VideoConverter do
  it "should raise an exception if there is not a proper video type" do
    @converter = Voyeur::VideoConverter.create(format: :asd).should raise_error
  end
end
