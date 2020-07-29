class ClothsController < ApplicationController
  def index
    @paginate = params[:page].to_i

    @number_records = Cloth.all.count

    @number_per_page = 8

    @number_of_pages = @number_records.to_f / @number_per_page

    if (@number_of_pages - @number_of_pages.to_i) > 0
      @number_of_pages = @number_of_pages.to_i + 1 
    else
      @number_of_pages = @number_of_pages.to_i
    end


    if @paginate.present?
      if @paginate == 1
        @cloth_paginate = Cloth.where("id <= ?",(@paginate+(@number_per_page-1)))
      elsif @paginate == @number_of_pages
        @cloth_paginate = Cloth.where("id >= ?", (@paginate+((@number_of_pages-1)*(@number_per_page-1))))
      else
        @cloth_paginate = Cloth.where("id <= ? and id > ?", (@number_per_page*@paginate) , (@number_per_page*@paginate)-@number_per_page)
      end
    end



  
  end 

  def about
    @artist = params[:market]
  end

  def market
    @artist = params[:market]

    @cloths_from_store = Cloth.where("artist = ?", @artist)
  end

  def carts
    @cloth_id = params[:id]
    Stock.delete(Stock.where('cloth_id = ?', @cloth_id).ids[0])


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
    redirect_to action: 'carts' 
  end

  def discount
    #@stock = CourseQuery.where(id: params[:id], status: 0).update(stock)
  end

  def favorites
    @cloth_id = params[:id]

    #Lógica para criar uma linha no model Favorite, caso a peça selecionada
    #ainda não esteja dentro dos favoritos
    if Favorite.where('cloth_id = ?', @cloth_id).present?
      #deixar uma mensagem de alerta dizendo que a peça já foi incluida nos favs
    else
      @cloth = Favorite.new
      @cloth.cloth_id = @cloth_id
      @cloth.save
    end

    #Lógica para exibirmos todas as cloths que estão no model Favorite
    @array_fav_ids = []
    @id_fav = Favorite.all.select('cloth_id')

    for i in @id_fav
      @array_fav_ids.append(i.cloth_id)
    end

    @results = Cloth.find(@array_fav_ids)
  end   
  
  def unfavorite
    @cloth_id = params[:id]

    #Lógica para deletarmos uma cloth dos model Favorite
    Favorite.delete(Favorite.where('cloth_id = ?', @cloth_id).ids)

    @array_fav_ids = []
    @id_fav = Favorite.all.select('cloth_id')

    for i in @id_fav
      @array_fav_ids.append(i.cloth_id)
    end


    @results = Cloth.find(@array_fav_ids)


  end


  private def post_params
    params.require(:cloth).permit(:name, :artist, :style, :url)
  end



end
