# app/serializers/company_serializer.rb
class CompanySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :legal_name, :director_name, :director_designation, :director_contact,
             :address, :email, :primary_phone, :primary_contact_name, :primary_contact_phone,
             :review_status, :rejection_reason, :created_at, :updated_at,
             :certificate_of_incorporation_url, :gst_certificate_url, :pan_document_url

  belongs_to :user
  has_one :certificate_of_incorporation
  has_one :gst_certificate
  has_one :pan_document


  def certificate_of_incorporation_url
    rails_blob_url(object.certificate_of_incorporation, only_path: true) if object.certificate_of_incorporation.attached?
  end

  def gst_certificate_url
    rails_blob_url(object.gst_certificate, only_path: true) if object.gst_certificate.attached?
  end

  def pan_document_url
    rails_blob_url(object.pan_document, only_path: true) if object.pan_document.attached?
  end

  class DocumentSerializer < ActiveModel::Serializer
    attributes :id, :doc_type, :file, :created_at, :updated_at
  end
end
