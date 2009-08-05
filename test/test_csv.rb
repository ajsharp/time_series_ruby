require File.dirname(__FILE__) + "/test_helper.rb"

class TimeSeries::Importers::CSVTest < Test::Unit::TestCase
  include FileHelper
  context "a valid CSV import instance" do
    setup do
      @csv = TimeSeries::Importers::CSV.new(fixtures[:csv_file])
    end

    should "implement the process_file method" do
      assert_nothing_raised { @csv.process_file }
    end

    should "implement the extract_headers method" do
      assert_nothing_raised { @csv.extract_headers }
    end

    should "implement the extract_datapoints method" do
      assert_nothing_raised { @csv.extract_datapoints }
    end
    
    should "have a file_name attribute" do
      assert_not_nil @csv.file_name
    end

    should "set the file_type attribute to csv" do
      assert_equal "csv", @csv.file_type
    end

    should "have a datapoints method" do
      assert_respond_to @csv, :datapoints
    end

    should "have a headers method" do
      assert_respond_to @csv, :headers
    end
  end

  context "instance methods" do
#    context "import!" do
#      setup do
#        @file = File.dirname(__FILE__) + "/../fixtures/csv_file.csv"
#        @csv = TimeSeries::Import::CSV.new(@file)
#        @new_series = @csv.import!
#      end
#
#      should "return a new TimeSeries instance" do
#        assert_instance_of TimeSeries, @new_series
#      end
#
#      should "populate the data in the TimeSeries instance" do
#        assert !@new_series.datapoints.empty?
#        assert_instance_of TimeSeries::Datapoint, @new_series.datapoints.first
#      end
#
#      should "populate the @headers in TimeSeries" do
#        assert !@new_series.headers.empty?
#      end
#    end
    
    context "abstract method implementations" do
      setup do
        @csv = TimeSeries::Importers::CSV.new(fixtures[:csv_file])
      end
      
      should "process_file should return a FasterCSV::Table instance" do
        assert_instance_of FasterCSV::Table, @csv.process_file
      end

      should "extract_headers should return an array with [:date, :value]" do
        assert_instance_of Array, @csv.extract_headers
        assert_equal [:date, :value], @csv.extract_headers
      end

      should "extract_datapoints should return an array with Datapoint objects" do
        assert_instance_of Array, @csv.extract_datapoints
        assert_instance_of Array, @csv.extract_datapoints.first
      end
    end
  end
end
