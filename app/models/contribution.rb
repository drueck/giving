class Contribution < ActiveRecord::Base

  attr_accessible :amount, :date_string, :contributor_id, :reference, :payment_type, :status

  belongs_to :contributor
  belongs_to :batch

  attr_writer :date_string

  before_validation :save_date_string

  validates :contributor_id, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :check_date_string
  validate :presence_of_date

  # note: on this virtual attribute date stuff, generally just use one or the other...
  # either use the virtual attribute and it will work great, or use the real one and it
  # will work great, but if you try to mix and match there will be unexpected issues
  # for example, if you set the string version and then set the date version, the string
  # version will overwrite the date version because of the before_validation save calls

  def date_string
    @date_string || date_to_string(self.date)
  end

  def check_date_string
    if @date_string.present? && Chronic.parse(@date_string).nil?
      errors.add :date_string, 'is invalid'
    end
  end

  def save_date_string
    self.date = string_to_date(@date_string) if @date_string
  end

  def presence_of_date
    if self.date.nil?
      errors.add :date, "can't be blank"
      errors.add :date_string, "can't be blank"
    end
  end

  # private helpers
  def date_to_string(d)
    (d.nil? ? nil : d.strftime("%m/%d/%Y"))
  end
  protected :date_to_string

  def string_to_date(s)
    Chronic.parse(s)
  end
  protected :string_to_date

end
