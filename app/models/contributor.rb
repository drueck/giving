class Contributor < ActiveRecord::Base

  include Comparable

  has_many :posted_contributions, dependent: :destroy

  validates :name, presence: true

  def <=>(other)
    name <=> other.name
  end

  def self.names_search(query)
    if query.present?
      where("name @@ :q", q: query)
    else
      all
    end
  end

end
