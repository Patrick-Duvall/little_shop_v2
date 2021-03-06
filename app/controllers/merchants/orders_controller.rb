class Merchants::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @items = @order.items_of_merchant(current_user.id)
  end

  def fulfill
    order = Order.find(params[:id])
    order_item = OrderItem.find(params[:order_item])
    item = order_item.item
    order_item.update!(fulfilled: true)
    order_item.item.update!(inventory: (item.inventory - order_item.quantity))

    flash[:message] = "Fulfilled item #{order_item.item.name} of this order"
    order.update(status:  1) if order.all_fulfilled?
    redirect_to merchant_order_path(order)
  end
end
