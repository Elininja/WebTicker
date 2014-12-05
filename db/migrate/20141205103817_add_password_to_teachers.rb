class AddPasswordToTeachers < ActiveRecord::Migration
  def change
    change_table :teachers do |t|
      t.string :password_digest
    end
  end
end
