# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'livecd'

spec = Gem::Specification.new do |s|
  s.name = 'livecd'
  s.licenses = ['MPLv2']
  s.version = Livecd::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "run livecds easily"
  s.description = s.summary
  s.author = "Dominik Richter"
  s.email = "dominik.richter@googlemail.com"
  s.homepage = 'https://github.com/arlimus/livecd'

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
