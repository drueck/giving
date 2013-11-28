class PostedContribution < Contribution

  default_scope { where('contributions.status = ?', 'Posted') }

  after_initialize :set_status_to_posted

  def destroy
    mark_deleted
    save
  end

  protected

  def set_status_to_posted
    self.status = 'Posted'
  end

  def mark_deleted
    self.status = 'Deleted'
  end

end
