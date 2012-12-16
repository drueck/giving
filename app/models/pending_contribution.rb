class PendingContribution < Contribution

  default_scope where('status = ?', 'Pending') 

  after_initialize :set_status_to_pending

  def set_status_to_pending
    self.status = 'Pending'
  end

  def self.total_amount_pending
    sum(:amount)
  end

end