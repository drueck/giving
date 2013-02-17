class AddPhoneAndEmailToContributors < ActiveRecord::Migration
  def change
    add_column :contributors, :phone, :string
    add_column :contributors, :email, :string
  end
end
