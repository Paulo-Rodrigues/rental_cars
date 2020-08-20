class SubsidiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_subsidiary, only: [:show, :edit, :update]

  def index
    @subsidiaries = Subsidiary.all
  end

  def show; end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.create(subsidiary_params)
    
    redirect_to @subsidiary
  end

  def edit; end

  def update
    if @subsidiary.update(subsidiary_params)
      redirect_to @subsidiary
    else
      render 'edit'
    end
  end

  private

  def find_subsidiary
    @subsidiary = Subsidiary.find(params[:id])
  end

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end
end
