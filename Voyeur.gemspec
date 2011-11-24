# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "Voyeur/version"

Gem::Specification.new do |s|
  s.name        = "voyeur"
  s.version     = Voyeur::VERSION
  s.authors     = ["Peter Garbers", "Hendrik F. Louw"]
  s.email       = ["peter.garbers@gmail.com", "hflouw@gmail.com"]
  s.homepage    = "http://devthenet.github.com/Voyeur"
  s.summary     = %q{Ruby library to convert common video formats to HTML5 formats}
  s.description = %q{A ruby library to convert videos into common html5 formats}

  s.rubyforge_project = "Voyeur"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_dependency "open4"
end
