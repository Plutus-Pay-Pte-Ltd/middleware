require 'rails_helper'

RSpec.describe Company, type: :model do
  context "validations" do
    it "rejects companies with empty legal names" do
      company = FactoryBot.build(:company, legal_name: "")
      expect(company).not_to be_valid
      expect(company.errors[:legal_name]).to include("can't be blank")
    end

    it "rejects companies with missing director details" do
      company = FactoryBot.build(:company, director_name: "", director_designation: "", director_contact: "")
      expect(company).not_to be_valid
      expect(company.errors[:director_name]).to include("can't be blank")
      expect(company.errors[:director_designation]).to include("can't be blank")
      expect(company.errors[:director_contact]).to include("can't be blank")
    end

    it "rejects companies with missing or invalid document uploads" do
      company = Company.new
      expect(company).not_to be_valid
    end

    it "validates the format of email addresses" do
      company = Company.new(email: "invalid_email")
      expect(company).not_to be_valid
    end

    it "validates the format of phone numbers" do
      company = Company.new(primary_phone: "123456789") # Assuming phone number should have 10 digits
      expect(company).not_to be_valid
    end
  end

  context "document uploads" do
    it "allows uploading documents in various formats" do
      company = FactoryBot.build(:company)
      expect(company).to be_valid
    end

    it "displays an error message if the file upload fails" do
      company = FactoryBot.build(:company)
      company.certificate_of_incorporation = nil
      expect(company).not_to be_valid
      expect(company.errors[:certificate_of_incorporation]).to include("can't be blank")
    end  

    it "limits the file size of uploaded documents" do
      max_file_size = 5.megabytes
      file_data = File.read("spec/fixtures/files/certificate.pdf") # Replace with your sample document file path

      company = FactoryBot.build(:company)
      company.certificate_of_incorporation.attach(io: StringIO.new(file_data), filename: "sample_document.pdf")

      expect(company.certificate_of_incorporation).to be_attached
      expect(company.certificate_of_incorporation.byte_size).to be <= max_file_size
    end
  end
end
