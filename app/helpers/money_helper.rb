module MoneyHelper

  def round_to_cent(amount)
    amount = amount.to_f
    amount_string = '%.2f' % amount
    BigDecimal.new(amount_string, 8)
  end
  protected :round_to_cent

end
