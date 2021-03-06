# dev hint: shotgun login.rb

require 'rubygems'
require 'sinatra'
require 'bundler'
Bundler.require :default


PDFKit.configure do |config|
    config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
    config.default_options = {
        'margin-top' => 0,
        'margin-bottom' => 0,
        'margin-left' => 0,
        'margin-right' => 0
    }
end

get '/download_statuts' do
    content_type 'application/pdf'
    url = 'Mon pdf de test'
    kit = PDFKit.new url
    kit.to_pdf
end

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
  @company_name = params[:company_name]
  puts @company_name
  @company_address = params[:company_address]
  puts @company_address
  @activity = params[:activity]
  puts @activity
  @date_exercice = params[:date_exercice]
  puts @date_exercice
  @capital1 = params[:capital1]
  puts @capital1
  @capital2 = params[:capital2]
  puts @capital2
  @capital3 = params[:capital3]
  puts @capital3
  @capital4 = params[:capital4]
  puts @capital4
  @capital5 = params[:capital5]
  puts @capital5
  @move = params[:move]
  puts @move
  @banque = params[:banque]
  puts @banque
  @inalienabilite = params[:inalienabilite]
  puts @inalienabilite
  @president_name = params[:president_name]
  puts @president_name
  @president_surname = params[:president_surname]
  puts @president_surname
  @president_address = params[:president_address]
  puts @president_address
  @president_date = params[:president_date]
  puts @president_date
  @lieu = params[:lieu]
  puts @lieu
  erb :statuts
end

get '/welcome' do 
  erb :welcome
end


get '/mentions_question' do
    erb :mentions_question
end

get '/mentions_perso_question' do
    erb :mentions_perso_question
end

get '/mentions_perso_form' do 
    erb :mentions_perso_form
end

post '/mentions_perso' do
  @mail_perso = params[:mail_perso]
  puts @mail_perso
  @host = params[:host]
  puts @host
  @host_adress = params[:host_adress]
  puts @host_adress
  @host_phone = params[:host_phone]
  puts @host_phone
  erb :mentions_perso
end

get '/about' do
    erb :about
end

$LOAD_PATH.unshift(Dir.getwd)
