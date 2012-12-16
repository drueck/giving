class AddPostedAtToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :posted_at, :datetime, null: false
  end
end
