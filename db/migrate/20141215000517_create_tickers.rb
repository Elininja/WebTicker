class CreateTickers < ActiveRecord::Migration
  def change
    create_table :tickers do |t|
      t.string :teacher
      t.string :name
    end
  end
end
