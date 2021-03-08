class ArtistsController < ApplicationController
  get '/artists' do
    @artists = Artist.all
    erb :'artist/index' 
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :'artist/show' 
  end

  delete '/artists/:slug/delete' do
    @artist = Artist.find_by_slug(params[:slug])
    @artist.delete 
    redirect '/artists' 
  end
end
