require File.dirname(__FILE__) + "/test_helper.rb"

class TimeSeries::Importers::CSVTest < Test::Unit::TestCase
  include FileHelper

  context "a valid CSV import instance" do
    setup do
      @importer = TimeSeries::Importer.new(fixtures[:csv_file], :builder_class => TimeSeries::Importers::CSV)
      @importer.import!
      @csv = @importer.builder_instance
    end

    #should "implement the process_file method" do
    #  assert_nothing_raised { @csv.process_file }
    #end

    #should "implement the extract_headers method" do
    #  assert_nothing_raised { @csv.extract_headers }
    #end

    #should "implement the extract_datapoints method" do
    #  assert_nothing_raised { @csv.extract_datapoints }
    #end
    
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

    context "abstract method implementations" do
      setup do
        @importer = TimeSeries::Importer.new(fixtures[:csv_file], :builder_class => TimeSeries::Importers::CSV)
        @importer.import!
        assert_equal TimeSeries::Importers::CSV, @importer.builder_class
        assert_not_nil @importer.file_name
        assert_instance_of Array, @importer.raw_data
      end
      
      #should "process_file should return a FasterCSV::Table instance" do
      #  assert_instance_of Array, @importer.raw_data
      #end

      #should "extract_headers should return an array with [:date, :value]" do
      #  assert_instance_of Array, @importer.headers
      #  assert_equal ["date", "value"], @importer.headers
      #end

      #should "extract_datapoints should return an array with Datapoint objects" do
      #  assert_instance_of Array, @importer.datapoints
      #  assert_instance_of TimeSeries::Datapoint, @importer.datapoints.first
      #  assert_equal 2, @importer.datapoints.size
      #end
    end # end of abtract method implementations

  end # end of instance methods
end
