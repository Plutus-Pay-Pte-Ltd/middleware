FactoryBot.define do
  factory :company do
    legal_name { Faker::Company.name }
    address { Faker::Address.full_address }
    email { Faker::Internet.unique.email }
    primary_phone { Faker::PhoneNumber.phone_number.gsub(/\D/, '').rjust(10, '0') }
    primary_contact_name { Faker::Name.name }
    primary_contact_phone { Faker::PhoneNumber.phone_number.gsub(/\D/, '').rjust(10, '0') }
    director_name { Faker::Name.name }
    director_designation { Faker::Job.title }
    director_contact { Faker::PhoneNumber.phone_number }
    review_status { 'pending' }
    certificate_of_incorporation { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'certificate.pdf'), 'application/pdf') }
    gst_certificate { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'gst_certificate.pdf'), 'application/pdf') }
    pan_document { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'pan_document.pdf'), 'application/pdf') }
    association :user

    trait :approved do
      review_status { 'approved' }
    end

    trait :rejected do
      review_status { 'rejected' }
    end
  end
end
