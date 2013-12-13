class RemovePostedAtFromBatches < ActiveRecord::Migration
  def change
    remove_column :batches, :posted_at, :datetime, null: false
  end
end
