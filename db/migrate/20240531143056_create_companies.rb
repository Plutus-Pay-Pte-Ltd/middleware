class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :legal_name
      t.string :address
      t.string :email
      t.string :primary_phone
      t.string :primary_contact_name
      t.string :primary_contact_phone

      t.timestamps
    end
  end
end
