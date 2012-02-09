require 'rubygems'
require 'bundler/setup'
require 'appraisal'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

task :default => :test
desc 'Run Errational tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
