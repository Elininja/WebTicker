class AssignListToTeacher < ActiveRecord::Migration
  def change
    change_table :teachers do |t|
      t.string :list_name
    end
  end
end
