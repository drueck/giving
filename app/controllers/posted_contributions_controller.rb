class ContributionsController < ApplicationController

  before_filter :require_login

  def index
    @contributions = Contribution
      .order('date desc, id desc')
      .paginate(page: params[:page], per_page: 10)
      .decorate
    @contribution = Contribution.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @contribution = Contribution.find(params[:id])
  end

  def new
    @contribution = Contribution.new
  end

  def create
    @contribution = Contribution.new(contribution_params)
    if @contribution.save
      respond_to do |format|
        format.html { redirect_to contributions_url, notice: 'Contribution saved' }
        format.js do
          @contributions = Contribution.order('date desc, id desc')
            .paginate(page: 1, per_page: 10).decorate
          @contribution = Contribution.new
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
    @contribution = Contribution.find(params[:id])
  end

  def update
    @contribution = Contribution.find(params[:id])
    if @contribution.update_attributes(contribution_params)
      redirect_to contributions_url, notice: 'Contribution updated'
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

  def contribution_params
    if params[:contribution][:date]
      params[:contribution][:date] =
        Chronic.parse(params[:contribution][:date])
    end
    params.require(:contribution).permit(:amount, :date,
      :contributor_id, :reference, :payment_type, :status)
  end

end
