class Contribution < ActiveRecord::Base

  attr_accessible :amount, :date, :contributor_id, :reference, :type

  belongs_to :contributor

end