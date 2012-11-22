class Contributor < ActiveRecord::Base
  attr_accessible :address, :city, :first_name, :last_name, :state, :zip
end
