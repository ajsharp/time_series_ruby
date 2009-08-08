class TimeSeries
  DEFAULT_OPTIONS = { :name => "New Series" }
  attr_accessor :datapoints, :name, :headers

  def initialize(name = "", *datapoints)
    @name = name
    @datapoints = []
    add_datapoints(*datapoints)
    @headers = []
  end
  
  def add_datapoint(point)
    @datapoints << point
  end

  def add_datapoints(*points)
    points.each { |point| add_datapoint(point) } 
  end

  def import!(file_name)
    import = TimeSeries::Import.new(file_name)
    import.import!(self)
  end

  
end
