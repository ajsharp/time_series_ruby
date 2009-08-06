require File.dirname(__FILE__) + "/test_helper.rb"

class TimeSeries::ImporterTest < Test::Unit::TestCase
  include FileHelper
  context "a valid Import object" do
    setup do
      @importer = TimeSeries::Importer.new(fixtures[:csv_file])
    end

    should "have a filename field" do
      assert_not_nil @importer.file_name
    end

    should "have a filetype attribute" do
      assert_not_nil @importer.file_type
    end

    should "attempt to guess the filetype" do
      assert_equal "csv", @importer.file_type
    end

    should "have an importer attribute which holds the class of the Builder class" do
      assert_not_nil @importer.builder_class
    end

    should "allow the file_type to be specified" do
      csv_importer = TimeSeries::Importer.new(fixtures[:csv_file], :file_type => "csv")
      assert_equal "csv", csv_importer.file_type
    end

    should "raise an error if an invalid filename is passed in" do
      assert_raise(IOError) { TimeSeries::Importer.new("BAD FILE NAME") }
    end
  end

  context "determing the correct Builder class based on the filename" do
    should "return TimeSeries::Importers::CSV if passed any string that ends in .csv" do
      begin
        %w(filename.csv filename.ext.csv filename.xml.csv).each do |filename|
          importer = TimeSeries::Importer.new(filename)
          assert_equal "csv", importer.file_type
          assert_equal TimeSeries::Importers::CSV, importer.builder_class
        end
      rescue IOError
      end
    end

    should "return the override option if one is passed in" do
      importer = TimeSeries::Importer.new(fixtures[:csv_file], :builder_class => TimeSeries::Importers::CSV)
      assert_equal TimeSeries::Importers::CSV, importer.builder_class
    end
  end

  context "import!" do
    setup do
      @importer = TimeSeries::Importer.new(fixtures[:csv_file], :builder_class => TimeSeries::Importers::CSV)
      @importer.import!
    end

    should "populate :raw_data" do
      assert_instance_of FasterCSV, @importer.raw_data
    end

    should "populate :datapoints" do
      assert !@importer.datapoints.empty?
      assert_instance_of TimeSeries::Datapoint, @importer.datapoints.first
    end

    context "the first TimeSeries::Datapoint returned" do
      should "return 2009/01/01 for the date" do
        assert_equal "2009/01/01", @importer.datapoints.first.date
      end

      should "return 12.5 for the float value of the value" do
        assert_equal 12.5, @importer.datapoints.first.value.to_f
      end
    end
  end

end
