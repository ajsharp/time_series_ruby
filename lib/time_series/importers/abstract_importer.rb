
module TimeSeries::Importers

  module AbstractImporter
    def process_file
      raise NotImplementedError, "Please implement this method in a subclass"
    end
  
    def extract_headers
      raise NotImplementedError, "Please implement this method in a subclass"
    end
  
    def extract_data
      raise NotImplementedError, "Please implement this method in a subclass"
    end
  end

end
