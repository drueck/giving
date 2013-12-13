class SetDefaultContributionStatusToPending < ActiveRecord::Migration
  def up
    change_column :contributions, :status, :string, null: false, default: "Pending"
  end
  def down
    change_column :contributions, :status, :string
  end
end
