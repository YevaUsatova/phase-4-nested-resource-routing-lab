class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def index
    if params[:user_id]
      users = User.find(params[:user_id])
      items = users.items
    else
      items = Item.all    
    end
    render json: items, include: :user  
  end

  def show
    if params[:id]
      items = Item.find(params[:id]) 
    else
      items = Item.all    
    end
    render json: items, include: :user
  end

  def create
    
     items = Item.create(new_params) 
     render json: items, include: :users, status: :created
  end

  private

  def render_not_found_response
    render json: {error: "Not found"}, status: :not_found
  end
  def new_params
    params.permit[:name, :description, :price]
  end

end
