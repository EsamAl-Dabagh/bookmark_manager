require './lib/bookmark.rb'
require 'sinatra/base'
require 'sinatra/flash'
require 'uri'

class BookmarkManager < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get "/" do
    erb :index
  end

  get "/bookmarks" do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  post "/bookmarks/add" do

    flash[:notice] = "You must submit a valid URL" unless Bookmark.add(params[:url])

    redirect "/bookmarks"
  end

  run! if app_file == $PROGRAM_NAME
end
