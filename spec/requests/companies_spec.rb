require 'rails_helper'

RSpec.describe "Company Actions", type: :request do
  let(:compliance_officer) { FactoryBot.create(:user, role: 'compliance_officer') }
  let(:company) { FactoryBot.create(:company, review_status: 'pending') }

  before do
    post session_path, params: { email: compliance_officer.email, password: compliance_officer.password }
  end

  describe "POST /companies/:id/approve" do
    it "approves the company" do
      patch approve_company_path(company)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "POST /companies/:id/reject" do
    it "rejects the company with a reason" do
      reason = "Incomplete documentation"
      patch reject_company_path(company), params: { rejection_reason: reason }
      expect(company.reload.review_status).to eq('rejected')
      expect(company.rejection_reason).to eq(reason)
    end
  end
end
