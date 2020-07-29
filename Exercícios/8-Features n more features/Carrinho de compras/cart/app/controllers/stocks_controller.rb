class StocksController < ApplicationController
  def new
  end

  def create
    @stock = Stock.new(post_params)

    @stock.save
    redirect_to action: 'new'
  end

  def discount
    @tamanho = params[:stock][:tamanho]
    @cor = params[:cor]
    @cloth_id = params[:cloth_id]
    
=begin   

    Essa lógica era usada para deletar uma linha do Model
    Stock assim que o usuário clicasse em "Save Stock"

    @stock = Stock.all.where("tamanho = ? AND cor = ? AND cloth_id = ?", @tamanho, @cor, @cloth_id)

    @stock = @stock.map{|s| [s.id]}

    @stock_destroy = Stock.destroy(@stock[0]) 
=end

  end



  private def post_params
    params.require(:stock).permit(:stock, :cloth_id, :tamanho, :cor)
  end
end
