class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username, null: false
      t.string :crypted_password, default: nil
      t.string :salt, default: nil
      t.string :user_type, null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
