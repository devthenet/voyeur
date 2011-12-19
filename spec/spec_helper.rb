require 'rspec'
require 'voyeur'
require 'spec_helpers/video_file_spec_helper'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

include SpecHelper::VideoFileSpecHelper
