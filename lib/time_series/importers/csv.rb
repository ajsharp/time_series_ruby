require 'fastercsv' 

class TimeSeries
  module Importers
  
    class CSV < TimeSeries::Importer
      include TimeSeries::Importers::AbstractImporter

      def initialize(filename)
        @file_name = filename
        @file_type = 'csv'
        @raw_data = process_file
      end
    
      def import!
        csv_table = FasterCSV.table(@file_name)
        series.headers = csv_table.headers
        csv_table.each { |p| series.add_datapoint(TimeSeries::Datapoint.new(p[0], p[1])) }
        series
      end

      def process_file
        FasterCSV.table(@file_name)
      end

      # Returns an array of Datapoint object
      def extract_datapoints
        @raw_data.each { |row| [row[0], row[1]] }
      end

      # This method is expected to return an Array of headers
      def extract_headers
        @raw_data.headers
      end
    
    end

  end # end of module Importers

end # end of class TimeSeries
