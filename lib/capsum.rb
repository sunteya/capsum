require "capistrano"

module Capsum
  VERSION = open(File.expand_path("../../VERSION", __FILE__)).read.chomp
end
