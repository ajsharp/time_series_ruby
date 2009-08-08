require File.dirname(__FILE__) + "/test_helper.rb"

class TimeSeriesTest < Test::Unit::TestCase
  include FileHelper
  context "a valid TimeSeries instance" do
    setup do
      @timeseries = TimeSeries.new("../fixtures/csv_file.csv")
      assert(@timeseries)
    end
    
    should "have a datapoints array attribute" do
      assert_instance_of(Array, @timeseries.datapoints)
    end
    
    should "have a name" do
      assert_not_nil(@timeseries.name)
      assert_instance_of(String, @timeseries.name)
    end

    should "have a headers attribute" do
      assert_not_nil @timeseries.headers
    end
  end # end of a valid TimeSeries

  context "instance methods" do
    context "add_datapoint" do
      setup do
        @timeseries = TimeSeries.new
      end
      
      should "add one datapoint to the datapoints attribute" do
        assert_equal 0, @timeseries.datapoints.size
        @timeseries.add_datapoint(TimeSeries::Datapoint.new(DateTime.now, 1))
        assert_equal 1, @timeseries.datapoints.size
      end
    end # end of add_datapoint

    context "add_datapoints" do
      setup do
        @series = TimeSeries.new("sample")
        @point1 = TimeSeries::Datapoint.new("2009/01/01", 1.0)
        @point2 = TimeSeries::Datapoint.new("2009/01/02", 2.0)
      end

      should "add an array of Datapoint instances to the @datapoints array" do
        assert_equal [], @series.datapoints
        @series.add_datapoints(@point1, @point2)
        assert_equal [@point1, @point2], @series.datapoints
      end
    end # end of add_datapoints
  end # end of instance methods

  context "creating a new dataset via a CSV import" do
    setup do
      @series = TimeSeries.new
      assert @series.datapoints.empty?
      @series.import!(fixtures[:csv_file])
    end

    should "populate the :datapoints array with the data from the CSV file" do
      assert !@series.datapoints.empty?
    end

    should "create the first datapoint with the data in the first data row of the fixtures file" do
      assert_equal @series.datapoints.first.date, "2009/01/01"
      assert_equal @series.datapoints.first.value.to_f, 12.5
    end
  end
  
end
