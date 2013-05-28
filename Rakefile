require 'rake'
require 'rake/clean'

VERSION = '0.5'
GEMSPEC = 'livecd.gemspec'
GEM = "livecd-#{VERSION}.gem"

desc 'Build the gem'
task :build do
  sh "mkdir -p target"
  sh "gem build #{GEMSPEC}"
  sh "mv #{GEM} target/"
end

task :default
