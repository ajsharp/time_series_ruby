
class TimeSeries
  
  class Import
    attr_accessor :file_name, :file_type, :import_class

    def initialize(file_name)
      @file_name    = set_file_name(file_name)
      @file_type    = determine_file_type
      @import_class = determine_import_class
    end

    def import!(context)
      @import_class.import!(@file_name, context)
    end

    private
      def set_file_name(name)
        raise(IOError, "File does not exist!") unless File.file?(name)
        @file_name = name
      end

      def determine_file_type
        file_name.split(".").last
      end

      def determine_import_class
        case @file_type
        when "csv"
          TimeSeries::Importers::CSV
        end
      end
  end

end
