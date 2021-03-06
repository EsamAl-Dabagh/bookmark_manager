require './lib/bookmark.rb'
require 'sinatra/base'
require 'sinatra/flash'
require 'uri'

class BookmarkManager < Sinatra::Base

  use Rack::MethodOverride

  enable :sessions
  register Sinatra::Flash

  get "/" do
    redirect "/bookmarks"
  end

  get "/bookmarks" do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  post "/bookmarks/new" do

    flash[:notice] = "You must submit a valid URL" unless Bookmark.add(params[:url], params[:title])

    redirect "/bookmarks"
  end

  delete "/bookmarks/:id/delete" do
    "Trying to delete bookmark"
    id = params[:id]
    Bookmark.delete(id)
    redirect "/bookmarks"
  end

  run! if app_file == $PROGRAM_NAME
end
