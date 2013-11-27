class RemoveAmountFromContributions < ActiveRecord::Migration
  def change
    remove_column :contributions, :amount, :decimal, precision: 8, scale: 2, default: 0.0, null: false
  end
end
