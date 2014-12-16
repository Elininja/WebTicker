class CreateUsersAndTickers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_type
      t.string :password_digest
    end

    create_table :tickers do |t|
      t.string :user_name
    end

    create_table :tickers_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :ticker
    end
  end
end
