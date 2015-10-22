class NotesController < ApplicationController
  before_action :check_ownership, only: :destroy

  def edit
    @note = Note.find(params[:id])
    render :edit
  end

  def update
    @note = Note.find(params[:id])
    @note.update(note_params)

    if @note.save
      redirect_to track_url(@note.track)
    else
      flash_errors(@note)
      redirect_to track_url(@note.track)
    end
  end

  def new
    @note = Note.new

    render :new

  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.track_id = params[:track_id]

    if @note.save
      redirect_to track_url(@note.track)
    else
      flash_errors(@note)
      redirect_to track_url(@note.track)
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to track_url(@note.track)
  end

private
  def note_params
    params.require(:note).permit(:user_id, :track_id, :note_text)
  end

  def check_ownership
    @note = Note.find(params[:id])
    unless @note.user == current_user
      render status: :forbidden, text: "403 Forbidden"
    end
  end
end
