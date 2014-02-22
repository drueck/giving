module DateParsing

  def normalize_date_param!
    if params[:contribution][:date]
      params[:contribution][:date] = Chronic.parse(params[:contribution][:date])
    end
  end

end
