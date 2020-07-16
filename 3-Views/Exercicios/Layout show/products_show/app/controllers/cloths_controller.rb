class ClothsController < ApplicationController
  def index
  end 
  
  def new
  end

  def search
    if params[:search].blank?  
      redirect_to(root_path, alert: "Empty field!") and return  
    else  
      @parameter = params[:search].downcase
      @results = Cloth.all.where("name LIKE ?", "%" + @parameter + "%") 
    end  
  end

  def create
    @cloth = Cloth.new(post_params)

    @cloth.save
    redirect_to action: 'new' 
  end

  private def post_params
    params.require(:cloth).permit(:name, :style, :url)
  end
end
