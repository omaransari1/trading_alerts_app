class RemoveValueFromStocks < ActiveRecord::Migration[5.0]
  def change
    remove_column :stocks, :value, :float
  end
end
