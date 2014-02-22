module ContributionsHelper

  def smart_edit_contribution_path(contribution)
    if display_in_batch?
      edit_batch_contribution_path(contribution.batch, contribution)
    else
      edit_contribution_path(contribution)
    end
  end

  def display_in_batch?
    params[:batch_id].present?
  end

end
