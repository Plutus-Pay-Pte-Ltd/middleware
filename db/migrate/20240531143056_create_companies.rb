class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :legal_name
      t.string :address
      t.string :email
      t.string :primary_phone
      t.string :primary_contact_name
      t.string :primary_contact_phone
      t.string :director_name
      t.string :director_designation
      t.string :director_contact
      t.string :review_status, default: 'pending'
      t.string :rejection_reason

      t.timestamps
    end
  end
end
