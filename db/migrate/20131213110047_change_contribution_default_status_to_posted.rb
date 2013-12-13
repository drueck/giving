class ChangeContributionDefaultStatusToPosted < ActiveRecord::Migration
  def up
    change_column :contributions, :status, :string, null: false, default: "Posted"
  end
  def down
    change_column :contributions, :status, :string, null: false, default: "Pending"
  end
end
