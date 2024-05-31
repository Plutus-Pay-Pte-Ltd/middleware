class Company < ApplicationRecord
  has_many :documents, dependent: :destroy
  validates :legal_name, :address, :email, :primary_phone, :primary_contact_name, :primary_contact_phone, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :primary_phone, :primary_contact_phone, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }
  validates :review_status, inclusion: { in: %w[pending approved rejected] }

  after_initialize :set_default_review_status, if: :new_record?

  accepts_nested_attributes_for :documents # Allow nested attributes for documents

  def pending_review?
    review_status == 'pending'
  end

  private

  def set_default_review_status
    self.review_status ||= 'pending'
  end
end
