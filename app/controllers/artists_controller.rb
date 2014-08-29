class ArtistsController < ApplicationController
  before_action :require_login
  before_action :require_admin, except: [:index, :show]

  def index
    @artists = Artist.all.order(:name)
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to artists_url
    else
      fail_to(:new)
    end
  end

  def edit
    current_artist
  end

  def update
    if current_artist.update(artist_params)
      redirect_to artist_url(current_artist)
    else
      fail_to(:edit)
    end
  end

  def show
    current_artist
    @albums = current_artist.albums.order(:release_date)
  end

  def destroy
    current_artist.destroy!
    redirect_to artists_url
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end

  def current_artist
    @artist = Artist.find(params[:id])
  end

  def fail_to(method)
    flash.now[:errors] = @artist.errors.full_messages
    render method
  end
end
