class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :address
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
