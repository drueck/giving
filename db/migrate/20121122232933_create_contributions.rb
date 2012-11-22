class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :contributor_id, null: false
      t.date :date, null: false
      t.string :type
      t.string :reference
      t.decimal :amount, precision: 8, scale: 2, null: false, default: 0.0

      t.timestamps
    end
  end
end
