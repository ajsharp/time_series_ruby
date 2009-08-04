require 'bigdecimal'
class Datapoint
  attr_accessor :date, :value
  
  def initialize(date, value)
    @date   = date
    @value  = BigDecimal.new(value.to_s)
  end
end