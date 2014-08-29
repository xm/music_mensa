class TracksController < ApplicationController
  before_action :require_login

  def new
    @album = Album.find(params[:album_id])
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to album_url(@track.album)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @album = current_track.album
    current_track
  end

  def update
    if current_track.update(track_params)
      redirect_to track_url(@track)
    else
      fail_to(:edit)
    end
  end

  def show
    @note = Note.new
    current_track
  end

  def destroy
    album = current_track.album
    current_track.destroy!
    redirect_to album_url(album)
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :name, :number, :bonus, :lyrics)
  end

  def current_track
    @track = Track.find(params[:id])
  end

  def fail_to(method)
    flash.now[:errors] = @track.errors.full_messages
    render method
  end
end
