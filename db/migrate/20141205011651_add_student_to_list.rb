class AddStudentToList < ActiveRecord::Migration
  def change
    change_table :lists do |t|
      t.string :student_name
    end
  end
end
