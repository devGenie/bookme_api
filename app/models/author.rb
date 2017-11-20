class Author < ApplicationRecord
    belongs_to :author
    has_many :books, dependent: :destroy
end
