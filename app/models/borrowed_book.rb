class BorrowedBook < ApplicationRecord
  belongs_to :book
  belongs_to :subscription
end
