class SalesController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
  
  end

  def create
    @sale = Sale.new(post_params)

    @sale.save
    redirect_to action: "index"
  end

  private def post_params
    params.require(:sale).permit(:amount, :client_id, :product_id)
  end
end
