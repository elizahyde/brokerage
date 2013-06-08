;class StocksPortfoliosBridge < ActiveRecord::Migration
  def change
    create_table :portfolios_stocks do |t|
      t.integer :portfolio_id
      t.integer :stock_id
    end
  end
end
