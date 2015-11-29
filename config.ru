# This file is used by Rack-based servers to start the application.

require 'rubygems'
ENV['GEM_HOME']="/home/jkropka/.rvm/gems/ruby-2.1.2"
ENV['GEM_PATH']="/home/jkropka/.rvm/gems/ruby-2.1.2"

Gem.clear_paths

require 'bundler'
Bundler.require

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
