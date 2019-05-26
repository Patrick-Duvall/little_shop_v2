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

  def new
    @merchant = current_user
  end

  def create
    adding = Item.new(item_params)
    adding.save

    redirect_to "/dashboard##{adding.id}"
  end

  def edit
    @item = Item.find(params[:id])    
  end

  def update
    Item.find(params[:id]).update(item_params)    
    flash[:note] = "Item updated."
    redirect_to '/dashboard'
  end

  def enable
    Item.update(params[:id], active: true)
    flash[:note] = "Item has been enabled."
    redirect_to "/dashboard#item-#{params[:id]}"
  end

  def disable
    Item.update(params[:id], active: false)
    flash[:note] = "Item has been disabled."
    redirect_to "/dashboard#item-#{params[:id]}"
  end

  def destroy
    Item.destroy(params[:id])
    flash[:note] = "Item has been deleted."
    redirect_to '/dashboard'
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :image, :inventory)
  end
end
