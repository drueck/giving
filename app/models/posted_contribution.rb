class PostedContribution < Contribution

  default_scope where('status = ?', 'Posted') 

  after_initialize :set_status_to_posted

  def set_status_to_posted
    self.status = 'Posted'
  end

end
