class Library < ApplicationRecord
  belongs_to :user
  has_many :subscriptions, dependent: :destroy
  validates_presence_of :name, :contacts, :location
end
