require 'rubygems'
require 'sinatra'
require 'settings'

before do
  session[:sid] = (rand(Time.now)) unless session[:sid]
end

get '/' do
  @items = Item.magic
  @votes = Vote.all(:session_id => session[:sid].to_s).collect{|x| x.item_id}
  haml :index
end

get '/like/:id' do
  Item.get(params[:id]).votes.create(:session_id => session[:sid].to_s)
  redirect '/'
end

get '/comments/:id' do
  @item = Item.get(params[:id])
  @votes = Vote.all(:session_id => session[:sid].to_s).collect{|x| x.item_id}
  haml :comments
end

get '/style.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :style
end

