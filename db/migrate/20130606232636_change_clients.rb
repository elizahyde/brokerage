class ChangeClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.integer :retirement
      t.integer :zipcode
    end
  end
end