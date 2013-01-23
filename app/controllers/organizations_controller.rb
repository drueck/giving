class OrganizationsController < ApplicationController

  def edit
    @organization = Organization.first || Organization.create
  end

  def update
    @organization = Organization.first
    if(@organization.update_attributes(params[:organization]))
      redirect_to root_url
    else
      render 'edit'
    end
  end

end
