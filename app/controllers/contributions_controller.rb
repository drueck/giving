class ContributionsController < ApplicationController

  before_filter :require_login

  def index
    @contributions = Contribution.scoped\
      .order('date desc, id desc')\
      .paginate(page: params[:page], per_page: 10)
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
    @contribution = Contribution.new(params[:contribution])
    if @contribution.save
      respond_to do |format|
        format.html { redirect_to contributions_url, notice: 'Contribution saved' }
        format.js do
          @contributions = Contribution.scoped\
            .order('date desc, id desc')\
            .paginate(page: 1, per_page: 10)
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
    if @contribution.update_attributes(params[:contribution])
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

end
