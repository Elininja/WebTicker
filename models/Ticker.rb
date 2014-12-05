class Student < ActiveRecord::Base
  belongs_to :User
  has_and_belongs_to_many :lists
end

class Teacher < ActiveRecord::Base
  belongs_to :User
  has_many :lists
end

class List < ActiveRecord::Base
  belongs_to :Teacher
  has_and_belongs_to_many :students
end
