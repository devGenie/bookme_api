class Author < ApplicationRecord
    belongs_to :user
    has_many :books, dependent: :destroy
    validates_presence_of :name
end
