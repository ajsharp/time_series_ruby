class TimeSeries

  class Importer
    attr_accessor :file_name, :file_type, :datapoints, :headers

    # Holds an instance of the TimeSeries::Import subclass that processed the file
    # (i.e. if file was .csv, @importer = TimeSeries::Import::CSV.new)
    attr_reader   :importer, :raw_data
  
    def initialize(filename, opts = {})
      @file_name = filename
      @file_type = opts[:filetype] || guess_filetype(filename)
      @importer  = determine_import_builder_class
      @process   = [:process_file, :extract_headers, :extract_datapoints]
    end
  
    def import!
      @importer.new(filename)
      @process.inject("") do |acc, method|
        acc += importer.send method if importer.responds_to?(method)
        acc
      end
    end
  
    private
      def guess_filetype(filename)
        filename.split(".").last
      end

      def determine_import_builder_class
        @importer = case file_type.to_sym
        when :csv
          TimeSeries::Importers::CSV
        end
      end
  end

end
