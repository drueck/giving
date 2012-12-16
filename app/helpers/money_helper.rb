module MoneyHelper

  def round_to_cent(amount)
    amount = amount.to_f if !amount.respond_to?(:round)
    BigDecimal.new(amount.round(2), 8)
  end
  protected :round_to_cent

end
