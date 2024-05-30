class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.string :doc_type
      t.string :file
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
