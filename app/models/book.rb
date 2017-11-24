class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  belongs_to :library
  has_many   :book_collections
end
