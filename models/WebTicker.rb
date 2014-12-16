class Ticker < ActiveRecord::Base
  # Make sure we don't have any duplicate usernames
  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :users
end

class User < ActiveRecord::Base

  # Make sure we don't have any duplicate usernames
  validates :name, presence: true, uniqueness: true

  # add the methods for secure password authentication
  has_secure_password

  has_and_belongs_to_many :tickers
end
