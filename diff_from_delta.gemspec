# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "diff_from_delta/version"

Gem::Specification.new do |s|
  s.name        = "diff_from_delta"
  s.version     = DiffFromDelta::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Henry Turner"]
  #s.email       = ["TODO: Write your email address"]
  #s.homepage    = ""
  s.summary     = %q{A ruby helper to decode diff deltas produced by diff-match-patch}
  #s.description = %q{A conversion of the python version to ruby.}
  
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"
  
  s.rubyforge_project = "diff_from_delta"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
