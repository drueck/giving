class ActiveContributorsController < ApplicationController

  before_filter :require_login

  def index
    @contributors = ActiveContributor.names_search(params[:query])\
      .order('last_name, first_name')\
      .paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @contributor = ActiveContributor.find(params[:id])
  end

  def new
    @contributor = ActiveContributor.new
  end

  def create
    @contributor = ActiveContributor.new(params[:active_contributor])
    if @contributor.save
      redirect_to active_contributors_url, notice: 'Successfully added new contributor'
    else
      render action: "new"
    end  
  end

  def edit
    @contributor = ActiveContributor.find(params[:id])
    @contributions = @contributor.posted_contributions\
      .order('date desc, id desc')\
      .paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @contributor = ActiveContributor.find(params[:id])
    if @contributor.update_attributes(params[:active_contributor])
      redirect_to active_contributors_url, notice: 'Successfully updated contributor info'
    else
      render action: 'edit'
    end
  end

  def destroy
    @contributor = ActiveContributor.find(params[:id])
    @contributor.destroy
    redirect_to active_contributors_url
  end

end
