class AddFirstNameAndLastNameToContributors < ActiveRecord::Migration
  def change
    add_column :contributors, :first_name, :string
    add_column :contributors, :last_name, :string
  end
end
