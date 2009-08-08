require File.dirname(__FILE__) + "/test_helper.rb"

class TimeSeries::ImportTest < Test::Unit::TestCase
  include FileHelper
  context "a valid Import" do
    setup do
      @import = TimeSeries::Import.new(fixtures[:csv_file])
    end

    should "have a :file_name attribute" do
      assert_not_nil @import.file_name
      assert_equal @import.file_name, fixtures[:csv_file]
    end

    should "have a :file_type attribute" do
      assert_not_nil @import.file_type
      assert_equal @import.file_type, "csv"
    end

    should "verify the file passed in is a real file" do
      assert_raise(IOError) { TimeSeries::Import.new("not a real file") }
    end

    should "automatically detect the file_type" do
      assert_equal TimeSeries::Import.new(fixtures[:xml]).file_type, "xml"
    end

    should "have an :import_class attribute" do
      assert_not_nil @import.import_class
      assert_equal @import.import_class, TimeSeries::Importers::CSV
    end

    context "autoselecting the :import_class attribute" do
      should "be to the TimeSeries::Importers::CSV when passing in a .csv file" do
        assert_equal TimeSeries::Import.new(fixtures[:csv_file]).import_class, TimeSeries::Importers::CSV
      end
    end
  end # end of a valid Import

  context "import!" do
    setup do
      @series = TimeSeries.new
      @import = TimeSeries::Import.new(fixtures[:csv_file])
    end

    should "populate the passed TimeSeries instances datapoints attribute" do
      assert @series.datapoints.empty?
      @import.import!(@series)
      assert !@series.datapoints.empty?
    end
  end
end
