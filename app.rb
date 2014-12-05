# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require
require './models/Ticker'
require './models/User'

set :session_secret, '85txrIIvTDe0AWPCvbeXuXXpULCWZgpoRo1LqY8YsR9GAbph0jfOHosvtY4QFxi6'

if ENV['DATABASE_URL']
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => 'db/development.db',
    :encoding => 'utf8'
  )
end

before do
  @user = User.find_by(name: session[:name])
end

get '/' do
  if @user
    #Find the right way to check if user is a teacher
    if @user.find_by(Teacher)
      erb :teacherpage
    else
      erb :waitingroom
    end
  else
    erb :login
  end
end

# Out login callback will recieve the submissions from
# the login form.
# ///////////////////////////////////
# TODO Make login page, register page
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
post '/login' do
  # Get a handle to a user with a name that matches the
  # submitted username. Returns nil if no such user
  # exists
  user = User.find_by(name: params[:name])

  if user.nil?
    # first, we check if the user is in our database
    @message = "User not found."
    erb :message_page

  elsif user.authenticate(params[:password])
    # if they are, we check if their password is valid,
    # then actually log in the user by setting a session
    # cookie to their username
    session[:name] = user.name
    redirect '/'

  else
    # if the password doesn't match our stored hash,
    # show a nice error page
    @message = "Incorrect password."
    erb :message_page
  end
end

# TODO Routes for:
#      1. taking a number
#      2. calling next number
#      3. creating users
# Don't forget to push to HEROKU!!!
