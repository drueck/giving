class BatchContributionsController < ApplicationController

  include DateParsing

	before_action :require_login
  before_action :find_batch
  before_action :find_contribution, only: [:edit, :update, :destroy]

  def index
    setup_for_index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @contribution = new_decorated_contribution
  end

  def create
    @contribution = new_decorated_contribution(contribution_params)
    respond_to do |format|
      format.html { create_html }
      format.js { create_js }
    end
  end

  def update
    if @contribution.update(contribution_params)
      redirect_to batch_contributions_path(@batch)
    else
      render :edit
    end
  end

  def destroy
    @contribution.mark_deleted
    redirect_to batch_contributions_path(@batch)
  end

  private

  def find_batch
    @batch = Batch.find(params[:batch_id]).decorate
  end

  def find_contribution
    @contribution = Contribution.find(params[:id]).decorate
  end

  def setup_for_index
    @contributions = @batch.contributions
      .order(id: :desc)
      .paginate(pagination_params).decorate
    @contribution = new_decorated_contribution
  end

  def create_html
    if @contribution.save
      redirect_to batch_contributions_path(@batch)
    else
      render :new
    end
  end

  def create_js
    if @contribution.save
      setup_for_index
    else
      render :refresh_form
    end
  end

  def new_decorated_contribution(attrs={})
    @batch.contributions.build(attrs).decorate
  end

  def contribution_params
    normalize_date_param!
    params.require(:contribution).permit(:amount, :date, :contributor_id,
      :reference, :payment_type)
  end

  def pagination_params
    { page: params.fetch(:page) { 1 }, per_page: params.fetch(:per_page) { 8 } }
  end

end
