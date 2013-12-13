class BatchDecorator < Draper::Decorator

  delegate_all

  def title
    name.present? ? name : "Batch #{id}"
  end

  def created_at_string
    return "" if created_at.nil?
    created_at.strftime("%B #{self.created_at.day.ordinalize}, %Y %-l:%M%P")
  end

end
