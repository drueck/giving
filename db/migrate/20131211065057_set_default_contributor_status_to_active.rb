class SetDefaultContributorStatusToActive < ActiveRecord::Migration
  def up
    change_column :contributors, :status, :string, null: false, default: "Active"
  end
  def down
    change_column :contributors, :status, :string
  end
end
