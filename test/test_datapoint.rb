require File.dirname(__FILE__) + "/test_helper.rb"

class TimeSeries::DatapointTest < Test::Unit::TestCase
  context "a valid Datapoint" do
    setup do
      @datapoint = TimeSeries::Datapoint.new(DateTime.now, 1)
    end
    
    should "have a date" do
      assert_not_nil(@datapoint.date)
    end
    
    should "have a date of type DateTime" do
      assert_instance_of(DateTime, @datapoint.date)
    end
    
    should "have a value" do
      assert_not_nil(@datapoint.value)
    end
    
    should "have a value of type BigDecimal" do
      assert_instance_of(BigDecimal, @datapoint.value)
      assert_equal("1.0", @datapoint.value.to_s)
    end
  end # end of a valid Datapoint
  
end
