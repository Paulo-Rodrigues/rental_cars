class SearchController < ApplicationController
  def index
    clients = Client.search(params[:q])
    rentals = Rental.search(params[:q])
    @search_result = clients + rentals
    @search_clients = clients
    @search_rentals = rentals
  end
end
