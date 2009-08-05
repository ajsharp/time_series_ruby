require File.dirname(__FILE__) + "/test_helper.rb"

class TimeSeriesTest < Test::Unit::TestCase
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

  context "class methods" do
#    context "new_from_file" do
#      setup do
#        @series = TimeSeries.new(File.dirname(__FILE__) + "/../fixtures/csv_file.csv")
#      end
#
#      should "load the data from the file passed in" do
#        assert !@series.datapoints.empty?
#      end
#    end
  end

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
  
end
