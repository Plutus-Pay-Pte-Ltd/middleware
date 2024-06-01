class CompanyMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def rejection_email(company, reason)
    @company = company
    @reason = reason
    mail(to: @company.email, subject: 'Company Registration Rejected')
  end

  def approval_notification(email, password)
    @email = email
    @password = password
    mail(to: email, subject: "Your KYC Request Has Been Approved")
  end
end
