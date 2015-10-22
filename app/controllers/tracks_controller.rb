class TracksController < ApplicationController

  before_action :verify_logged_in

  def index
    album = params[:album_id] && Album.find(params[:album_id])

    if album
      @tracks = album.tracks
    else
      @tracks = Track.all
    end

    render :index
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def new
    @track = Track.new
    @track.album_id = params[:album_id]
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash_errors_now(@track)
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    @track.update(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash_errors_now(@track)
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
  end

private
  def track_params
    params.require(:track).permit(:album_id, :title, :bonus, :lyrics)
  end
end
