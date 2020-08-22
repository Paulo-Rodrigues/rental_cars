class SearchController < ApplicationController
  def index
    @search_result = Client.where('name like ? or cpf = ?', "%#{params[:q]}%", params[:q])
  end
end
