class ChangeColumnPortfolio < ActiveRecord::Migration
  def change
    rename_column :portfolios, :type, :sector
  end
end
