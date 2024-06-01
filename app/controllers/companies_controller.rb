class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy, :approve, :reject]
  before_action :authorize_compliance_officer, only: %i[index show]
  before_action :authenticate_user!, except: %i[new create]

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    temporary_password = SecureRandom.hex(8)

    @user = User.new(email: company_params[:email], role: 0, password: temporary_password)
    @company = @user.build_company(company_params)

    if @user.save && @company.save
      flash[:notice] = 'Company was successfully created.'
      redirect_to root_path
    else
      flash[:alert] = 'Failed to create company. Please try again.'
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end

  def approve    
    password = SecureRandom.hex(8)

    @company.update(review_status: 'approved')
    @company.user.update(password: password)
    CompanyMailer.approval_notification(@company.user.email, password).deliver_now

    redirect_to @company
  end

  def reject
    rejection_reason = params[:rejection_reason]
    @company.update(review_status: 'rejected', rejection_reason:)
    CompanyMailer.rejection_email(@company, rejection_reason).deliver_now
    redirect_to companies_path, notice: 'Company rejected.'
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
end
