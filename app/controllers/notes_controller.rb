class NotesController < ApplicationController
  before_action :require_login
  before_action :validate_permission, only: [:delete]

  def create
    @note = Note.new(note_params)
    @note.track_id = params[:track_id]
    @note.user_id = current_user.id

    if @note.save
      redirect_to track_url(@note.track)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(@note.track)
    end
  end

  def destroy
    track = current_note.track
    current_note.destroy!
    redirect_to track_url(track)
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end

  def current_note
    @note = Note.find(params[:id])
  end

  def validate_permission
    unless current_user == current_note.author || current_user.is_admin?
      redirect_to track_url(current_note.track)
    end
  end
end
