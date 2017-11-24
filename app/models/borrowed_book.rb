class BorrowedBook < ApplicationRecord
  belongs_to :book_collection
  belongs_to :subscription
end
