class ContributionsController < ApplicationController

  include DateParsing
  include ContributorParamTranslation

  before_action :require_login
  before_action :find_contribution, only: [:edit, :update, :destroy]
  before_action :save_requesting_page, only: [:new, :edit]

  def index
    setup_for_index
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data ContributionCSV.new.generate }
    end
  end

  def new
    @contribution = Contribution.new.decorate
  end

  def create
    @contribution = Contribution.new(contribution_params).decorate
    respond_to do |format|
      format.html { create_html }
      format.js { create_js }
    end
  end

  def update
    if @contribution.update_attributes(contribution_params)
      redirect_to last_contributions_page
    else
      render action: 'edit'
    end
  end

  def destroy
    @contribution.mark_deleted
    redirect_to contributions_url
  end

  private

  def setup_for_index
    @contributions = Contribution
      .order('date desc, id desc')
      .paginate(page: params[:page], per_page: 10)
      .decorate
    @contribution = Contribution.new.decorate
  end

  def find_contribution
    @contribution = Contribution.find(params[:id]).decorate
  end

  def create_html
    if @contribution.save
      redirect_to last_contributions_page
    else
      render action: 'new'
    end
  end

  def create_js
    if @contribution.save
      setup_for_index
    else
      render :refresh_form
    end
  end

  def save_requesting_page
    session[:contributions_came_from] = request.referrer
  end

  def last_contributions_page
    session[:contributions_came_from] || contributions_path
  end

  def contribution_params
    normalize_date_param!
    set_contributor_id_param!
    params.require(:contribution).permit(:amount, :date, :batch_id,
      :contributor_id, :reference, :payment_type, :status)
  end

end
