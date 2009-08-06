class TimeSeries

  class Importer
    attr_accessor :file_name, :file_type, :datapoints, :headers, :raw_data 

    # Holds an instance of the TimeSeries::Import subclass that processed the file
    # (i.e. if file was .csv, @importer = TimeSeries::Import::CSV.new)
    attr_reader   :builder_class, :import_processes, :builder_instance
  
    def initialize(filename, opts = {})
      @file_name = set_filename(filename)
      @file_type = opts[:file_type] || determine_file_type
      @builder_class = opts[:builder_class]  || determine_import_builder_class

      @datapoints, @headers = [], []
      #@raw_data = ""
      @builder_instance = nil


      @import_processes = [:process_file, :extract_headers, :extract_datapoints]
    end
  
    def import!
      builder_instance = builder_class.new(file_name)
      #@import_processes.inject("") do |acc, method|
      #  acc += inst.send(method) if inst.responds_to?(method)
      #  acc
      #end
      @import_processes.each { |p| builder_instance.send(p) if builder_instance.respond_to?(p) } 
      @datapoints = builder_instance.datapoints
      @headers    = builder_instance.headers
      @raw_data   = builder_instance.raw_data
    end

  
    private
      def set_filename(name)
        raise(IOError, "File does not exist!") unless File.file?(name)
        @file_name = name
      end

      def determine_file_type
        file_name.split(".").last
      end

      def determine_import_builder_class
        TimeSeries::Importers::CSV
      end
  end

end
