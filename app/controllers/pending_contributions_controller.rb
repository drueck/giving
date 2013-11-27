class PendingContributionsController < ApplicationController

  before_filter :require_login

  def index
    setup_for_index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def post
    begin
      batch = Batch.new
      PendingContribution.transaction do
        batch.posted_at = Time.now
        batch.save!
        PendingContribution.all.each do |contribution|
           contribution.batch = batch
           contribution.status = 'Posted'
           contribution.save!
        end
      end
      redirect_to batch_path(batch)
    rescue Exception => e
      setup_for_index
      flash.now[:error] = 'An unexpected error occurred while attempting to post these contributions'
      logger.error e.message
      render 'index'
    end
  end

  def show
    @contribution = PendingContribution.find(params[:id])
  end

  def new
    @contribution = PendingContribution.new
    @contribution.date = last_date
  end

  def create
    @contribution = PendingContribution.new(contribution_params)
    if @contribution.save
      respond_to do |format|
        format.html { redirect_to pending_contributions_url, notice: 'Contribution saved' }
        format.js do
          setup_for_index
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
    if @contribution.update_attributes(contribution_params)
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

  protected

  def contribution_params
    if params[:pending_contribution][:date]
      params[:pending_contribution][:date] =
        Chronic.parse(params[:pending_contribution][:date])
    end
    params.require(:pending_contribution).permit(:amount, :date,
      :contributor_id, :reference, :payment_type, :status)
  end

  def setup_for_index
    @contributions = PendingContribution\
      .order('date desc, id desc')\
      .paginate(page: params[:page], per_page: 8)
    @contribution = PendingContribution.new
    @contribution.date = last_date
    @total_amount_pending = PendingContribution.total_amount_pending
  end

  def last_date
    PendingContribution.order('created_at').last.try(:date)
  end

end
