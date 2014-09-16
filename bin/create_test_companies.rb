#!/usr/bin/env ruby
#
# This script creates fake company data for development purposes
# Script can be executed with command
# ruby bin/create_test_companies.rb [number of companies to create]
#

current_dir = File.expand_path(File.dirname(__FILE__))
require current_dir + '/../config/boot.rb'
require current_dir + '/../config/environment'

if ARGV.length >= 1
  number_of_companies = ARGV[0].to_i
else
  puts "Usage: ruby bin/create_test_companies.rb [number of companies to create]"
  exit 1
end

Company.create_test_data(number_of_companies)
