class ContributorsController < ApplicationController

  def index
    @contributors = Contributor.all
  end

  def show
    @contributor = Contributor.find(params[:id])
  end

  def new
    @contributor = Contributor.new
  end

  def create
    @contributor = Contributor.new(params[:contributor])
    if @contributor.save
      redirect_to contributors_url, notice: 'Successfully added new contributor'
    else
      render action: "new"
    end  
  end

  def edit
    @contributor = Contributor.find(params[:id])
  end

  def update
    @contributor = Contributor.find(params[:id])
    if @contributor.update_attributes(params[:contributor])
      redirect_to contributors_url, notice: 'Successfully updated contributor info'
    else
      render action: 'edit'
    end
  end

  def destroy
    @contributor = Contributor.find(params[:id])
    @contributor.destroy
    redirect_to contributors_url
  end

end
