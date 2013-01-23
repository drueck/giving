class Organization < ActiveRecord::Base
  
  attr_accessible :address, :city, :name, :phone, :state, :zip

  def address_lines
    lines = Array.new
    lines << name if name.present?
    lines << address if address.present?
    lines << city_state_zip if city_state_zip.present?
    lines << phone if phone.present?
    lines
  end

  protected

  def city_state_zip
    result = String.new
    result << city if city.present?
    if(state.present?)
      result << ', ' if result.length > 0
      result << state
    end
    if(zip.present?)
      result << ' ' if result.length > 0
      result << zip
    end
    result
  end

end
