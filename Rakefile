# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'livecd'

require 'rake'
require 'rake/clean'

VERSION = Livecd::VERSION
GEMSPEC = 'livecd.gemspec'
GEM = "livecd-#{VERSION}.gem"

desc 'Build the gem'
task :build do
  sh "mkdir -p target"
  sh "gem build #{GEMSPEC}"
  sh "mv #{GEM} target/"
end

task :default
