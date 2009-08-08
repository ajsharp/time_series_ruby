require 'fastercsv' 

class TimeSeries
  module Importers
  
    class CSV

      def self.import!(file_name, context)
        raw_data = FasterCSV.readlines(file_name)
        context.headers = raw_data.shift
        context.datapoints = raw_data.collect { |r| TimeSeries::Datapoint.new(r[0], r[1]) }
      end

    end

  end # end of module Importers

end # end of class TimeSeries
