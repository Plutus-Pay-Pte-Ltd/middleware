class Company < ApplicationRecord
  has_one_attached :certificate_of_incorporation
  has_one_attached :gst_certificate
  has_one_attached :pan_document

  validates :legal_name, :director_name, :director_designation, :director_contact,
            :address, :email, :primary_phone, :primary_contact_name, :primary_contact_phone,
            presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :primary_phone, :primary_contact_phone, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }
  validates :certificate_of_incorporation, :gst_certificate, :pan_document, presence: true

  MAX_FILE_SIZE = 5.megabytes

  validate :validate_file_size
  belongs_to :user

  def pending_review?
    review_status == 'pending'
  end

  private

  def validate_file_size
    validate_attachment_file_size(:certificate_of_incorporation)
    validate_attachment_file_size(:gst_certificate)
    validate_attachment_file_size(:pan_document)
  end

  def validate_attachment_file_size(attribute)
    if send(attribute).attached? && send(attribute).blob.byte_size > MAX_FILE_SIZE
      errors.add(attribute, "file size exceeds the maximum limit of #{MAX_FILE_SIZE / 1.megabyte}MB")
    end
  end
end
