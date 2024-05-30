class AddReviewStatusToCompanies < ActiveRecord::Migration[7.1]
  def change
    add_column :companies, :review_status, :string
  end
end
