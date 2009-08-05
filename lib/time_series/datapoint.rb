require 'bigdecimal'

# Very simple Datapoint model to be used with TimeSeries models
#
# Only takes two fields: <tt>:date</tt> and <tt>:value</tt>
# 
class TimeSeries::Datapoint
  attr_accessor :date, :value
  
  def initialize(date, value)
    @date   = date
    @value  = BigDecimal.new(value.to_s)
  end
end
