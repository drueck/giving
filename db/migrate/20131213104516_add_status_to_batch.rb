class AddStatusToBatch < ActiveRecord::Migration
  def change
    add_column :batches, :status, :string, null: false, default: "Posted"
  end
end
