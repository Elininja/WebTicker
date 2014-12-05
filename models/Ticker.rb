class Student < ActiveRecord::Base
  belongs_to :User
end

class Teacher < ActiveRecord::Base
  belongs_to :User
  has_many :lists
end

class List < ActiveRecord::Base
  belongs_to :Teacher
  has_many :students
end
