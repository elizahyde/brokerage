class AddStocksToPortfolios < ActiveRecord::Migration
  # This adds stock ids to portfolios

class AddPortfoliosToClients < ActiveRecord::Migration
  def up
    add_column :portfolios, :stock_id, :integer
  end

  def down
    remove_column :portfolios, :stock_id
  end
end