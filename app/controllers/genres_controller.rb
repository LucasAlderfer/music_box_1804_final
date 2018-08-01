class GenresController < ApplicationController

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    require_admin
    @genre = Genre.create(genre_params)
    if @genre.save
      redirect_to genres_path
    else
      flash[:error] = 'Genre not created'
      render genres_path
    end
  end

  def show
    @genre = Genre.find(params[:id])
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
