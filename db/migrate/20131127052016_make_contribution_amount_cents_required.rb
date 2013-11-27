class MakeContributionAmountCentsRequired < ActiveRecord::Migration
  def up
    change_column :contributions, :amount_cents, :integer, null: false, default: 0
  end
  def down
    change_column :contributions, :amount_cents, :integer, null: true, default: nil
  end
end
