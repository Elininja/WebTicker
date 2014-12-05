class User < ActiveRecord::Base

  # Make sure we don't have any duplicate usernames
  validates :name, presence: true, uniqueness: true

  # add the methods for secure password authentication
  has_secure_password
end
