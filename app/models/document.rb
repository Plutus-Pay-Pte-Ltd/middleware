class Document < ApplicationRecord
  belongs_to :company
  has_one_attached :file

  validates :doc_type, :file, presence: true
end
