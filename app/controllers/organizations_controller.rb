class OrganizationsController < ApplicationController

	before_filter :require_login

  def edit
    @organization = Organization.first || Organization.create
  end

  def update
    @organization = Organization.first
    if(@organization.update_attributes(organization_params))
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:address, :city, :name,
      :phone, :state, :zip)
  end

end
