require 'spec_helper'

describe Voyeur::Converter do
  it "should raise an exception if there is not a proper video type" do
    lambda { Voyeur::Converter.create(:format => :asd) }.should raise_error
  end
end
