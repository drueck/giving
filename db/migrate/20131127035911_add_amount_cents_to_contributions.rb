class AddAmountCentsToContributions < ActiveRecord::Migration
  def up
    add_column :contributions, :amount_cents, :integer
    execute <<-SQL
      UPDATE contributions SET amount_cents = floor(amount * 100);
    SQL
  end

  def down
    execute <<-SQL
      UPDATE contributions SET amount = amount_cents::decimal(8,2) / 100;
    SQL
    remove_column :contributions, :amount_cents
  end
end
