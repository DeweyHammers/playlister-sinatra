require 'sinatra/base'
require 'rack-flash'

class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'song/index' 
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all
    erb :'/song/new' 
  end

  post '/songs' do
    @song = Song.create(params[:song])
    if !params['artist']['name'].empty?
      @artist = Artist.find_by(name: params['artist']['name'])
      @artist ? @song.update(artist: @artist) : @song.update(artist: Artist.create(params['artist']))
    end
    flash[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}" 
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'song/show'
  end

  get '/songs/:slug/edit' do
    @genres = Genre.all
    @song = Song.find_by_slug(params[:slug])
    erb :'song/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    if !params['song'].keys.include?('genre_ids')
      params['song']['genre_ids'] = []
    end
    if !params['artist']['name'].empty?
      @artist = Artist.find_by(name: params['artist']['name'])
      @artist ? @song.update(artist: @artist) : @song.update(artist: Artist.create(params['artist']))
    end
    @song.update(params['song'])
    flash[:message] = "Successfully updated song."
    redirect "/songs/#{@song.slug}"
  end

  delete '/songs/:slug/delete' do
    @song = Song.find_by_slug(params[:slug])
    @song.delete 
    redirect '/songs' 
  end
end