class AddColumnToStocks < ActiveRecord::Migration[5.0]
  def change
    add_column :stocks, :user_id, :integer
  end
end
