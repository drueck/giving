class AddNotesToContributor < ActiveRecord::Migration
  def change
    add_column :contributors, :notes, :text
  end
end
