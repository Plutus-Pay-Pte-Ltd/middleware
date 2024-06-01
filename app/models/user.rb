class User < ApplicationRecord
  has_secure_password
  enum role: { company_user: 0, compliance_officer: 1 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  has_one :company

  private

  def password_required?
    new_record? || password.present?
  end
end
