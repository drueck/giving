class ContributionsController < ApplicationController

  before_action :require_login

  def index
    @contributions = Contribution
      .order('date desc, id desc')
      .paginate(page: params[:page], per_page: 10)
      .decorate
    @contribution = Contribution.new.decorate
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @contribution = Contribution.find(params[:id]).decorate
  end

  def new
    @contribution = Contribution.new
    save_requesting_page
  end

  def create
    contribution_to_create = Contribution.new(contribution_params).decorate
    if contribution_to_create.save
      respond_to do |format|
        format.html { redirect_to last_contributions_page, notice: 'Contribution saved' }
        format.js do
          @contributions = Contribution.order('date desc, id desc')
          @contribution = Contribution.new.decorate
          if contribution_to_create.batch_id
            batch_id = contribution_to_create.batch_id
            @contributions = @contributions.where(batch_id: batch_id)
            @contribution.batch_id = batch_id
          end
          @contributions = @contributions.paginate(page: 1, per_page: 10).decorate
        end
      end
    else
      @contribution = contribution_to_create
      respond_to do |format|
        format.html { render action: 'new' }
        format.js { render 'refresh_form' }
      end
    end
  end

  def edit
    @contribution = Contribution.find(params[:id]).decorate
    save_requesting_page
  end

  def update
    @contribution = Contribution.find(params[:id]).decorate
    if @contribution.update_attributes(contribution_params)
      redirect_to last_contributions_page, notice: 'Contribution updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @contribution = Contribution.find(params[:id])
    @contribution.destroy
    redirect_to contributions_url
  end

  private

  def save_requesting_page
    session[:contributions_came_from] = request.referrer
  end

  def last_contributions_page
    session[:contributions_came_from] || contributions_path
  end

  def contribution_params
    if params[:contribution][:date]
      params[:contribution][:date] = Chronic.parse(params[:contribution][:date])
    end
    params.require(:contribution).permit(:amount, :date, :batch_id,
      :contributor_id, :reference, :payment_type, :status)
  end

end
