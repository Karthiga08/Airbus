module BookingsHelper

  def price_list(name)
    SeatCategory.price_amount(name).to_i
  end
end
