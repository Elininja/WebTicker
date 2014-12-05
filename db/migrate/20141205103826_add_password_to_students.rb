class AddPasswordToStudents < ActiveRecord::Migration
  def change
    change_table :students do |t|
      t.string :password_digest
    end
  end
end
