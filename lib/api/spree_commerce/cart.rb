# frozen_string_literal: true

module Cart
  def create_cart
    request(:create, ENV['URI_PATTERN'])
  end

  def add_items(token, item_data)
    request(:create, "#{ENV['URI_PATTERN']}/add_item", item_data, token)
  end
end
