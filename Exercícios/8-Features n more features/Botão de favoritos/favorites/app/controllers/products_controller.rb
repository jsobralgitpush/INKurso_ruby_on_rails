class ProductsController < ApplicationController
  def new
  
  end

  def create
    @product = Product.new(post_params)

    @product.save
    redirect_to :controller => 'sales', :action => 'index'
  end

  private def post_params
    params.require(:product).permit(:name, :description)
  end
end
