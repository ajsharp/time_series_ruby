require "test/unit"
require "rubygems"
require "ruby-debug"
require "shoulda"

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require "time_series"

begin
  require 'redgreen'
rescue LoadError
end


module FileHelper
  def fixtures
    {
      :csv_file => File.dirname(__FILE__) + "/../fixtures/csv_file.csv"
    }
  end
end
