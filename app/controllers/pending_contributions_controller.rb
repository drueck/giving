class PendingContributionsController < ApplicationController

  before_filter :require_login

  def index
    @contributions = PendingContribution\
      .order('date desc, id desc')\
      .paginate(page: params[:page], per_page: 10)
    @contribution = PendingContribution.new
    @total_amount_pending = PendingContribution.total_amount_pending
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @contribution = PendingContribution.find(params[:id])
  end

  def new
    @contribution = PendingContribution.new
  end

  def create
    @contribution = PendingContribution.new(params[:pending_contribution])
    if @contribution.save
      respond_to do |format|
        format.html { redirect_to pending_contributions_url, notice: 'Contribution saved' }
        format.js do
          @total_amount_pending = PendingContribution.total_amount_pending
          @contributions = PendingContribution.order('date desc, id desc').paginate(page: 1, per_page: 10)
          @contribution = PendingContribution.new
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
    @contribution = PendingContribution.find(params[:id])
  end
  
  def update
    @contribution = PendingContribution.find(params[:id])
    if @contribution.update_attributes(params[:pending_contribution])
      redirect_to pending_contributions_url, notice: 'Contribution updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @contribution = PendingContribution.find(params[:id])
    @contribution.destroy
    redirect_to pending_contributions_url
  end

end
