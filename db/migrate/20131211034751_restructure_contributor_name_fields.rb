class RestructureContributorNameFields < ActiveRecord::Migration
  def up
    remove_column :contributors, :first_name
    remove_column :contributors, :last_name
    rename_column :contributors, :household_name, :name
  end
  def down
    rename_column :contributors, :name, :household_name
    add_column :contributors, :first_name, :string, null: false
    add_column :contributors, :last_name, :string, null: false
  end
end
