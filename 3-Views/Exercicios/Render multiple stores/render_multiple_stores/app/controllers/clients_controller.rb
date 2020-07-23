class ClientsController < ApplicationController
  def new
  end

  def create
    @client = Client.new(post_params)

    @client.save
    redirect_to :controller => 'sales', :action => 'index'
  end

  private def post_params
    params.require(:client).permit(:name, :email)
  end
end
