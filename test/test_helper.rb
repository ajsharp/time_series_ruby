require "test/unit"
require "rubygems"
require "ruby-debug"
require "shoulda"
# require 'autotest'

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require "time_series"

begin
  require 'redgreen'
rescue LoadError
end

