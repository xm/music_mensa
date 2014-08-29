class AlbumsController < ApplicationController
  before_action :require_login
  before_action :requrie_admin, except: [:show]

  def new
    @artist = Artist.find(params[:artist_id])
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      fail_to(:new)
    end
  end

  def edit
    @artist = current_album.artist
    current_album
  end

  def update
    if current_album.update(album_params)
      redirect_to album_url(current_album)
    else
      fail_to(:edit)
    end
  end

  def show
    current_album
    @tracks = current_album.tracks.order(:number)
  end

  def destroy
    artist = current_album.artist
    current_album.destroy!
    redirect_to artist_url(artist)
  end

  def album_params
    params.require(:album).permit(:artist_id, :name, :release_date, :kind)
  end

  def current_album
    @album = Album.find(params[:id])
  end

  def fail_to(method)
    flash.now[:errors] = @album.errors.full_messages
    render method
  end
end
