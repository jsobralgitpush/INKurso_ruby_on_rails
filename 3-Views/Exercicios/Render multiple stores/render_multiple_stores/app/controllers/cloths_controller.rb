class ClothsController < ApplicationController
  def index
  end 
  
  def new
  end

  def search
    if params[:search].blank?  
      redirect_to(root_path) and return  
    else  
      @parameter = params[:search].downcase
      @results = Cloth.all.where("name LIKE ?", "%" + @parameter + "%") 
      session[:passed_variable] = @results
    end

  end

  def filter
    @gender = params[:gender]
    @tipo = params[:tipo]
    @price = params[:price]

    @results = session[:passed_variable]


    #Sem parametro 
    if params[:gender].blank? && params[:tipo].blank? && params[:price].blank? 
      redirect_back(fallback_location: root_path)
    
    #Apenas um parametro
    #a) gender
    elsif params[:tipo].blank? && params[:price].blank?
      @param_gender = params[:gender]
      @results = @results.select{|hash| hash['gender'] == @param_gender}

    
    #b) tipo
    elsif params[:gender].blank? && params[:price].blank?
      @param_style = params[:tipo]
      @results = @results.select{|hash| hash['style'] == @param_style}

    #c) price
    elsif params[:gender].blank? && params[:tipo].blank?
      @param_price = params[:price]
      @param_price = @param_price.split('_')
      @len = @param_price.length()
      if @len == 3 && @param_price[2] == '100'
        @results = @results.select{|hash| hash['price'] < @param_price[2].to_i}
      elsif @len == 3 && @param_price[2] == '200' 
        @results = @results.select{|hash| hash['price'] > @param_price[2].to_i}
      else
        @results = @results.select{|hash| hash['price'] > 100 && hash['price'] < 200 }
      end
    
    #Dois params
    #a) gender e tipo
    elsif params[:gender].present? && params[:tipo].present? && params[:price].blank?
      @param_style = params[:tipo]
      @param_gender = params[:gender]
      @results = @results.select{|hash| hash['style'] == @param_style && hash['gender'] == @param_gender}
      
    #b) gender e price
    elsif params[:gender].present? && params[:price].present? && params[:tipo].blank?
      @param_gender = params[:gender]
      @param_price = params[:price]
      @param_price = @param_price.split('_')
      @len = @param_price.length()
      if @len == 3 && @param_price[2] == '100'
        @results = @results.select{|hash| hash['price'] < @param_price[2].to_i && hash['gender'] == @param_gender}
      elsif @len == 3 && @param_price[2] == '200' 
        @results = @results.select{|hash| hash['price'] > @param_price[2].to_i && hash['gender'] == @param_gender}
      else
        @results = @results.select{|hash| hash['price'] > 100 && hash['price'] < 200  && hash['gender'] == @param_gender}
      end


    #c) tipo e price
    elsif params[:tipo].present? && params[:price].present? && params[:gender].blank? 
      @param_style = params[:tipo]
      @param_price = params[:price]
      @param_price = @param_price.split('_')
      @len = @param_price.length()
      if @len == 3 && @param_price[2] == '100'
        @results = @results.select{|hash| hash['price'] < @param_price[2].to_i && hash['style'] == @param_style}
      elsif @len == 3 && @param_price[2] == '200' 
        @results = @results.select{|hash| hash['price'] > @param_price[2].to_i && hash['style'] == @param_style}
      else
        @results = @results.select{|hash| hash['price'] > 100 && hash['price'] < 200  && hash['style'] == @param_style}
      end
    
    #Tres params
    else
      @param_gender = params[:gender]
      @param_style = params[:tipo]
      @param_price = params[:price]
      @param_price = @param_price.split('_')
      @len = @param_price.length()
      if @len == 3 && @param_price[2] == '100'
        @results = @results.select{|hash| hash['price'] < @param_price[2].to_i && hash['style'] == @param_style && hash['gender'] == @param_gender}
      elsif @len == 3 && @param_price[2] == '200' 
        @results = @results.select{|hash| hash['price'] > @param_price[2].to_i && hash['style'] == @param_style && hash['gender'] == @param_gender}
      else
        @results = @results.select{|hash| hash['price'] > 100 && hash['price'] < 200  && hash['style'] == @param_style && hash['gender'] == @param_gender}
      end

    end
  
  end 

  def item
    @cloth_id = params[:item]
    @results = Cloth.all.where("id = ?", @cloth_id)

    #nao precisa de all no where
    @stocks = Stock.all.where("cloth_id = ?", @cloth_id)
    @stocks_uniq_color = @stocks.map{|s|[s.cor]}.uniq

    if @stocks_uniq_color.length() == 0
      @var_test = 0
    else
      @var_test = 1
    end

    raise

  end

  def item_color
    @cloth_id = params[:item]
    @cloth_color = params[:color]
    @results = Cloth.all.where("id = ?", @cloth_id)

    @stocks = Stock.all.where("cloth_id = ? AND cor = ?", @cloth_id, @cloth_color)
    @stocks_uniq_tam = @stocks.map{|s|[s.cor]}.uniq

  end


  def create
    @cloth = Cloth.new(post_params)

    @cloth.save
    redirect_to action: 'new' 
  end

  def discount
    #@stock = CourseQuery.where(id: params[:id], status: 0).update(stock)
  


  end

  private def post_params
    params.require(:cloth).permit(:name, :artist, :style, :url)
  end

end
