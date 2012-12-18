class AddStatusToContributor < ActiveRecord::Migration
  def change
    add_column :contributors, :status, :string
  end
end
