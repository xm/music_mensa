class NotesController < ApplicationController
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

  private

  def note_params
    params.require(:note).permit(:content)
  end
end
