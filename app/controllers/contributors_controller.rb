class ContributorsController < ApplicationController

  before_action :require_login

  def index
    @contributors = Contributor.name_search(params[:query])
      .order(:name)
      .paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data ContributorCSV.new.generate }
    end
  end

  def show
    @contributor = Contributor.find(params[:id])
  end

  def new
    @contributor = Contributor.new
  end

  def create
    @contributor = Contributor.new(contributor_params)
    if @contributor.save
      redirect_to contributors_url
    else
      render action: "new"
    end
  end

  def edit
    @contributor = Contributor.find(params[:id])
    @contributions = page_of_contributions(@contributor)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @contributor = Contributor.find(params[:id])
    if @contributor.update_attributes(contributor_params)
      redirect_to contributors_url
    else
      @contributions = page_of_contributions(@contributor)
      render action: 'edit'
    end
  end

  def destroy
    @contributor = Contributor.find(params[:id])
    @contributor.mark_deleted
    redirect_to contributors_url
  end

  private

  def contributor_params
    params.require(:contributor).permit(:address, :city, :state, :zip,
      :name, :phone, :email, :notes, :first_name, :last_name)
  end

  def page_of_contributions(contributor)
    contributor.contributions
      .order('date desc, id desc')
      .paginate(page: params[:page], per_page: 10)
      .decorate
  end

end
