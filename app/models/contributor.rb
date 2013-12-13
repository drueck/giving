class Contributor < ActiveRecord::Base

  include Comparable

  default_scope { where(status: "Active") }

  has_many :contributions, dependent: :destroy

  validates :name, presence: true

  def <=>(other)
    name <=> other.name
  end

  def self.name_search(query)
    if query.present?
      where("name @@ :q", q: query)
    else
      all
    end
  end

  def mark_deleted
    self.class.transaction do
      mark_contributions_deleted
      mark_self_deleted
      save
    end
  end

  private

  def mark_self_deleted
    self.status = "Deleted"
  end

  def mark_contributions_deleted
    contributions.each do |c|
      c.mark_deleted
    end
  end

end
