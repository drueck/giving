class ContributionsController < ApplicationController

  def index
    @contributions = Contribution.all
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
      redirect_to contributions_url, notice: 'Contribution saved'
    else
      render action: "new"
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
