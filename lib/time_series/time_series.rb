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

  class << self
    def new_from_file(filename, opts = {})
      options = DEFAULT_OPTIONS.merge(opts)
      TimeSeries.new(options[:name], points)
    end

    def new_from_csv(filename, opts = {})
      import = TimeSeries::Importers::CSV.new(filename)

      options = DEFAULT_OPTIONS.merge(opts)
      series = TimeSeries.new(options[:name])
      series.add_datapoints(import.datapoints)
      series
    end
  end
  
end
