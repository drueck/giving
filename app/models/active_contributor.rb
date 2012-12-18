class ActiveContributor < Contributor

  default_scope where('status is null or status = ?', 'Active') 

  after_initialize :set_status_to_active

  def set_status_to_active
    self.status = 'Active'
  end
  protected :set_status_to_active

  def destroy
    ActiveContributor.transaction do
      posted_contributions.each do |posted_cont|
        posted_cont.destroy
      end
      mark_deleted
      save
    end
  end

  def mark_deleted
    self.status = 'Deleted'
  end
  protected :mark_deleted

end
