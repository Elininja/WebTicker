class Student < ActiveRecord::Base
  has_and_belongs_to_many :lists

  # Make sure we don't have any duplicate usernames
  validates :name, presence: true, uniqueness: true

  # add the methods for secure password authentication
  has_secure_password
end

class Teacher < ActiveRecord::Base
  has_many :lists

  # Make sure we don't have any duplicate usernames
  validates :name, presence: true, uniqueness: true

  # add the methods for secure password authentication
  has_secure_password
end

class List < ActiveRecord::Base
  belongs_to :Teacher
  has_and_belongs_to_many :students
end
