class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  enum status: ["pending", "packaged", "shipped", "cancelled"]

  def self.admin_dashboard_sort
    order("CASE orders.status
           WHEN 0 THEN 1
           WHEN 1 THEN 0
           END ASC, id ASC")
  end

  def self.top_three_order_item_quantity
    joins(:order_items)
          .select('orders.*', 'SUM(order_items.quantity) AS order_item_quantity')
          .group('orders.id')
          .order('order_item_quantity desc')
          .limit(3)

  end

  def user_name
    user.name
  end

  def user_id
    user.id
  end

  def total_item_count
    items.sum(:quantity)
  end

  def total_price
    order_items.sum(:price)
  end

  def cancel_items
    order_items.each do |order_item|
      if order_item.fulfilled
      order_item.reload
      order_item.update(fulfilled: false)
      new_quantity = order_item.item.inventory + order_item.quantity
      order_item.item.update(inventory: new_quantity)
      end
    end
  end
end
