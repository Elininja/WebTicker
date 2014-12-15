class User < ActiveRecord::Base

  # Make sure we don't have any duplicate usernames
  validates :name, presence: true, uniqueness: true

  # create the todo_items association, and
  # automatically delete all the user's todo items
  # if they delete their account
  has_and_belongs_to_many :tickers

  # add the methods for secure password authentication
  has_secure_password
end
