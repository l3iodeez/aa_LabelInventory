class BandsController < ApplicationController

  before_action :verify_logged_in

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash_errors_now(@band)
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    @band.update(band_params)

    if @band.save
      redirect_to band_url(@band)
    else
      flash_errors_now(@band)
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

end
