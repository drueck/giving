module ContributorParamTranslation

  def set_contributor_id_param!
    if params[:contributor_name]
      params[:contribution][:contributor_id] =
        Contributor.find_by(name: params[:contributor_name]).try(:id)
    end
  end

end
