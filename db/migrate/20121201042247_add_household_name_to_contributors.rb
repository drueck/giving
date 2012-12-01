class AddHouseholdNameToContributors < ActiveRecord::Migration
  def change
    add_column :contributors, :household_name, :string, null: false
  end
end
