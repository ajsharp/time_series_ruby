require 'fastercsv' 

class TimeSeries
  module Importers
  
    class CSV < TimeSeries::Importer
      include TimeSeries::Importers::AbstractImporter

      def process_file
        @raw_data = FasterCSV.readlines(@file_name)
      end

      # Returns an array of Datapoint object
      def extract_datapoints
        @datapoints = @raw_data.collect { |r| TimeSeries::Datapoint.new(r[0], r[1]) }
      end

      # This method is expected to return an Array of headers
      def extract_headers
        @headers = @raw_data.shift
      end
    
    end

  end # end of module Importers

end # end of class TimeSeries
