class TimeSeries
  attr_accessor :datapoints, :name
  
  def initialize(name = "", datapoints = [])
    @datapoints, @name = datapoints, name
  end
  
  def add_datapoint(point)
    @datapoints << point
  end
  
end