class AddUserIdToTickers < ActiveRecord::Migration
  def change
    change_table :tickers do |t|
      t.integer :user_id
    end
  end
end
