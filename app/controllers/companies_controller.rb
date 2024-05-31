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
    @company.documents.build
  end

  def create
    @company = Company.new(company_params)
    unless @company.save
      render :new
    else
      redirect_to root_path
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
    @company = Company.find(params[:id])
    @company.update(review_status: 'approved')
    redirect_to @company
  end

  def reject
    @company.update(review_status: 'rejected')
    # Additional logic for rejecting the company (e.g., send notification with reasons)
    redirect_to companies_path, notice: 'Company rejected.'
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(
      :legal_name, :address, :email, :primary_phone, :primary_contact_name, :primary_contact_phone,
      documents_attributes: [:doc_type, :file] # Permit nested attributes for documents
    )
  end  
end
