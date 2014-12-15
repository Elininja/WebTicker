class Ticker < ActiveRecord::Base
  # Make sure we don't have any duplicate usernames
  validates :name, presence: true, uniqueness: true

  has_many :users
end
