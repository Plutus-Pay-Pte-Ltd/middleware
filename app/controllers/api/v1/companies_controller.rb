# app/controllers/api/v1/companies_controller.rb
module Api
  module V1
    class CompaniesController < ApplicationController
      skip_before_action :authenticate_request, only: %i[create]
      before_action :set_company, only: [:show, :update, :destroy, :approve, :reject]
      before_action :authorize_compliance_officer, only: %i[index show]

      def index
        @companies = Company.all
        render json: @companies
      end

      def show
        render json: @company
      end

      def create
        temporary_password = SecureRandom.hex(8)

        @user = User.new(email: company_params[:email], role: 0, password: temporary_password)
        @company = @user.build_company(company_params)

        if @user.save && @company.save
          render json: { notice: 'Company was successfully created.', company: @company }, status: :created
        else
          render json: { error: @company.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @company.update(company_params)
          render json: { notice: 'Company was successfully updated.', company: @company }
        else
          render json: { error: 'Failed to update company.' }, status: :unprocessable_entity
        end
      end

      def destroy
        @company.destroy
        render json: { notice: 'Company was successfully destroyed.' }
      end

      def approve    
        password = SecureRandom.hex(8)
        @company.update(review_status: 'approved')
        @company.user.update(password: password)
        CompanyMailer.approval_notification(@company.user.email, password).deliver_now
        render json: { notice: 'Company approved.', company: @company }
      end

      def reject
        rejection_reason = params[:rejection_reason]
        @company.update(review_status: 'rejected', rejection_reason: rejection_reason)
        CompanyMailer.rejection_email(@company, rejection_reason).deliver_now
        render json: { notice: 'Company rejected.', company: @company }
      end

      private

      def set_company
        @company = Company.find(params[:id])
      end

      def company_params
        params.require(:company).permit(
          :legal_name, :director_name, :director_designation, :director_contact,
          :certificate_of_incorporation, :gst_certificate, :pan_document,
          :address, :email, :primary_phone, :primary_contact_name, :primary_contact_phone,
          documents_attributes: [:doc_type, :file]
        )
      end

      def authorize_compliance_officer
        render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user.compliance_officer?
      end
    end
  end
end
