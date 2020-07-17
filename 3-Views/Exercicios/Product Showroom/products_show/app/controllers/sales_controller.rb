class SalesController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
  
  end

  def search
    if params[:search].blank?  
      redirect_to(root_path, alert: "Empty field!") and return  
    else  
      @parameter = params[:search].downcase
      @second_paramater = Client.all.where("name LIKE ?", "%" + @parameter + "%").ids
      @results = Sale.all.where("client_id = :search", search: @second_paramater)  
    end  
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
