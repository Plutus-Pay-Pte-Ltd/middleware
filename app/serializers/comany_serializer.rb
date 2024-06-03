# app/serializers/company_serializer.rb
class CompanySerializer < ActiveModel::Serializer
  attributes :id, :legal_name, :director_name, :director_designation, :director_contact,
             :address, :email, :primary_phone, :primary_contact_name, :primary_contact_phone,
             :review_status, :rejection_reason, :created_at, :updated_at

  belongs_to :user
end

