class AddNotesToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :notes, :text
  end
end
