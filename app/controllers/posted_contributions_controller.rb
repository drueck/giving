class PostedContributionsController < ApplicationController

  before_filter :require_login

  def index
    @contributions = PostedContribution\
      .order('date desc, id desc')\
      .paginate(page: params[:page], per_page: 10)
    @contribution = PostedContribution.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @contribution = PostedContribution.find(params[:id])
  end

  def new
    @contribution = PostedContribution.new
  end

  def create
    @contribution = PostedContribution.new(contribution_params)
    if @contribution.save
      respond_to do |format|
        format.html { redirect_to posted_contributions_url, notice: 'Contribution saved' }
        format.js do
          @contributions = PostedContribution.order('date desc, id desc').paginate(page: 1, per_page: 10)
          @contribution = PostedContribution.new
        end
      end
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.js { render 'refresh_form' }
      end
    end
  end

  def edit
    @contribution = PostedContribution.find(params[:id])
  end

  def update
    @contribution = PostedContribution.find(params[:id])
    if @contribution.update_attributes(contribution_params)
      redirect_to posted_contributions_url, notice: 'Contribution updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @contribution = PostedContribution.find(params[:id])
    @contribution.destroy
    redirect_to posted_contributions_url
  end

  private

  def contribution_params
    if params[:posted_contribution][:date]
      params[:posted_contribution][:date] =
        Chronic.parse(params[:posted_contribution][:date])
    end
    params.require(:posted_contribution).permit(:amount, :date,
      :contributor_id, :reference, :payment_type, :status)
  end

end
