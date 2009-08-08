require File.dirname(__FILE__) + "/test_helper.rb"

class TimeSeries::Importers::CSVTest < Test::Unit::TestCase
  include FileHelper

  context "a valid CSV import instance" do
    setup do
      @series = TimeSeries.new
      TimeSeries::Importers::CSV.import!(fixtures[:csv_file], @series)
    end

    should "populate the :datapoints array with the data from the CSV file" do
      assert !@series.datapoints.empty?
    end

    should "create the first datapoint with the data in the first data row of the fixtures file" do
      assert_equal @series.datapoints.first.date, "2009/01/01"
      assert_equal @series.datapoints.first.value.to_f, 12.5
    end

    should "populate the headers with date and value" do
      assert !@series.headers.empty?
      assert_equal @series.headers.first, "date"
    end
  end

end
