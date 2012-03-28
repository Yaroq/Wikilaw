# dev hint: shotgun login.rb

require 'rubygems'
require 'sinatra'

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Hello stranger'
  end
end

before '/secure/*' do
  if !session[:identity] then
    session[:previous_url] = request['REQUEST_PATH']
    @error = 'Sorry guacamole, you need to be logged in to do that'
    halt erb(:login_form)
  end
end

get '/' do
  erb :home
end

get '/login/form' do 
  erb :login_form
end

post '/login/attempt' do
  session[:identity] = params['username']
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from 
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert-message'>Logged out</div>"
end


get '/secure/place' do
  erb "This is a secret place that only <%=session[:identity]%> has access to!"
end

post '/statuts' do
  @name = params[:name]
  puts @name
  @capital = params[:capital]
  puts @capital
  @adress = params[:adress]
  puts @adress
  @objet = params[:objet]
  puts @objet
  @move = params[:move]
  puts @move
  @banque = params[:banque]
  puts @banque
  @inalienabilite = params[:inalienabilite]
  puts @inalienabilite
  @lieu = params[:lieu]
  puts @lieu
  erb :statuts
end

get '/welcome' do 
  erb :welcome
end

get '/about' do
    erb :about
end

$LOAD_PATH.unshift(Dir.getwd)
