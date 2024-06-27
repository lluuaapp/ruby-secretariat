require "spec_helper"
require "./lib/secretariat"
require "./lib/secretariat/export"
require "./lib/secretariat/export/zugferd"

RSpec.describe Secretariat::Export::Zugferd, type: :module do
  let(:source_pdf) { Secretariat.file_path("spec/fixtures/zugferd_2/test_a1.pdf") }
  let(:source_xml) { Secretariat.file_path("spec/fixtures/zugferd_2/test-x.xml") }
  let(:output_dir) { Dir.mktmpdir }
  let(:output_filename) { "output.pdf" }
  let(:output_filename2) { "output2.pdf" }
  let(:output_filename3) { "output3.pdf" }
  let(:output_file_path) { File.join(output_dir, output_filename) }
  let(:output_file_path2) { File.join(output_dir, output_filename2) }
  let(:output_file_path3) { File.join(output_dir, output_filename3) }
  let(:attachments_pathlist) { "" }

  after(:each) do
    FileUtils.remove_entry(output_dir) if File.exist?(output_dir)
  end

  describe "convert_file" do
    it "converts a1 to a3" do
      result = Secretariat::Export::Zugferd.convert_to_a3(
        source_pdf: source_pdf,
        output_filename: output_filename,
        output_dir: output_dir
      )

      expect(result).to eq(output_file_path)
      expect(File.exist?(result)).to be(true)
    end
  end

  describe "combine_files" do
    it "combines PDF and XML files" do
      result = Secretariat::Export::Zugferd.combine_files(
        source_pdf: source_pdf,
        source_xml: source_xml,
        output_filename: output_filename2,
        output_dir: output_dir
      )

      expect(result).to eq(output_file_path2)
      expect(File.exist?(result)).to be(true)
    end
  end

  describe "convert_combine_files" do
    it "converts a1 to a3, then combines a3 and XML files" do
      result = Secretariat::Export::Zugferd.convert_and_combine(
        source_pdf: source_pdf,
        source_xml: source_xml,
        output_filename: output_filename3,
        output_dir: output_dir
      )

      expect(result).to eq(output_file_path3)
      expect(File.exist?(result)).to be(true)
    end
  end
end

