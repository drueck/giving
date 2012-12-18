class PostedContribution < Contribution

  default_scope where('status = ?', 'Posted') 

  after_initialize :set_status_to_posted

  def destroy
    mark_deleted
    save
  end

  def set_status_to_posted
    self.status = 'Posted'
  end
  protected :set_status_to_posted

  def mark_deleted
    self.status = 'Deleted'
  end
  protected :mark_deleted

end
