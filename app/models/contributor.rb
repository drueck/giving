class Contributor < ActiveRecord::Base

  include Comparable

  scope :active, -> { where(status: "Active") }

  has_many :posted_contributions, dependent: :destroy

  validates :name, presence: true

  def <=>(other)
    name <=> other.name
  end

  def self.names_search(query)
    if query.present?
      active.where("name @@ :q", q: query)
    else
      active
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
    posted_contributions.each do |c|
      c.destroy
    end
  end

end
