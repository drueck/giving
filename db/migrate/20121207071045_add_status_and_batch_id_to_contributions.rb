class AddStatusAndBatchIdToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :status, :string
    add_column :contributions, :batch_id, :integer
  end
end
