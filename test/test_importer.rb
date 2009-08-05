require File.dirname(__FILE__) + "/test_helper.rb"

class TimeSeries::ImporterTest < Test::Unit::TestCase
  context "a valid Import object" do
    setup do
      @importer = TimeSeries::Importer.new(File.dirname(__FILE__) + "/../fixtures/csv_file.csv")
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
      assert_not_nil @importer.importer
    end

    should "allow the file_type to be specified" do
      csv_importer = TimeSeries::Importer.new("csv_file.txt", :filetype => "csv")
      assert_equal "csv", csv_importer.file_type
    end
  end

  context "determing the correct Builder class based on the filename" do
    should "return TimeSeries::Importers::CSV if passed any string that ends in .csv" do
      %w(filename.csv filename.ext.csv filename.xml.csv).each do |filename|
        importer = TimeSeries::Importer.new(filename)
        assert_equal "csv", importer.file_type
        assert_equal TimeSeries::Importers::CSV, importer.importer
      end
    end
  end

end
