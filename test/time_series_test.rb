require File.dirname(__FILE__) + "/test_helper.rb"

class TimeSeriesTest < Test::Unit::TestCase
  context "a valid TimeSeries instance" do
    setup do
      @timeseries = TimeSeries.new
      assert(@timeseries)
    end
    
    should "have a datapoints array attribute" do
      assert_instance_of(Array, @timeseries.datapoints)
    end
    
    should "have a name" do
      assert_not_nil(@timeseries.name)
      assert_instance_of(String, @timeseries.name)
    end
    
    context "add_datapoint" do
      setup do
        @timeseries = TimeSeries.new
      end
      
      should "add one datapoint to the datapoints attribute" do
        assert_equal 0, @timeseries.datapoints.size
        @timeseries.add_datapoint(DataPoint.new(DateTime.now, 1))
        assert_equal 1, @timeseries.datapoints.size
      end
    end # end of add_datapoint
    
  end # end of a valid TimeSeries
  
end