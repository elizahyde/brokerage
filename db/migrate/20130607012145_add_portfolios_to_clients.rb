#File named wrong. This assigns a portfolio to one client
#so a client can have multiple portfolio

class AddPortfoliosToClients < ActiveRecord::Migration
  def up
    add_column :portfolios, :client_id, :integer
  end

  def down
    remove_column :portfolios, :client_id
  end
end