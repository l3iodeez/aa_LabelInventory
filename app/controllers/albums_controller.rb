class AlbumsController < ApplicationController

  helper_method :is_studio?, :is_live?
  before_action :verify_logged_in

  def index
    band = params[:band_id] && Band.find(params[:band_id])

    if band
      @albums = band.albums
    else
      @albums = Album.all
    end
    render :index
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def new
    @album = Album.new
    @album.band_id = params[:band_id]
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash_errors_now(@album)
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    @album.update(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash_errors_now(@album)
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
  end



private

  def album_params
    params.require(:album).permit(:title, :venue, :band_id)
  end
end
