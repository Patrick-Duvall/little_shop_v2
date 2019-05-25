class ItemsController < ApplicationController
  def index
    @items = Item.all
    @most_popular = @items.most_popular
    @least_popular = @items.least_popular
  end

  def show
    @item = Item.find(params[:id])
    @average_fulfillment_time = @item.average_fulfillment_time
  end

  def edit
    @item = Items.find(params[:id])    
  end

  def update
    redirect_to '/dashboard'
  end

  def enable
    Item.update(params[:id], active: true)
    redirect_to "/dashboard#item-#{params[:id]}"
  end

  def disable
    Item.update(params[:id], active: false)
    redirect_to "/dashboard#item-#{params[:id]}"
  end
end
