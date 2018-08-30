require './lib/bookmark.rb'
require 'sinatra/base'

class BookmarkManager < Sinatra::Base

  get "/" do
    erb :index
  end

  get "/bookmarks" do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  post "/bookmarks/add" do
    Bookmark.add(params[:url])

    redirect "/bookmarks"
  end

  run! if app_file == $PROGRAM_NAME
end
