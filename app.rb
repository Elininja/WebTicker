# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require
require './models/Ticker'

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
  @registered_student = Student.find_by(name: session[:name])
  @registered_teacher = Teacher.find_by(name: session[:name])
end

get '/' do
  if @registered_teacher or @registered_student
    if @registered_teacher
      erb :teacherpage
    else
      erb :waitingroom
    end
  else
    erb :login
  end
end

post '/choose_list/:list_name' do
  @list = params[:list_name]
  erb :listpage
end

# This login callback will recieve the submissions from
# the login form in 'login.erb'.
post '/login' do

  user = Teacher.find_by(name: params[:name])
  if user.nil?
    user = Student.find_by(name: params[:name])
  end

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

# TODO Extend V-this-V to Student/Teacher user format
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
post '/new_student' do
  @student = Student.create(params)
  if @student.valid?
    session[:name] = @student.name
    @message = 'Success! Student Account has been created.'
    erb :message_page
  else
    @message = @student.errors.full_messages.join(', ')
    erb :message_page
  end
end

post '/new_teacher' do
  @teacher = Teacher.create(params)
  if @teacher.valid?
    session[:name] = @teacher.name
    @message = 'Success! Teacher Account has been created.'
    erb :message_page
  else
    @message = @teacher.errors.full_messages.join(', ')
    erb :message_page
  end
end

get '/logout' do
  session.clear
  redirect '/'
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# TODO
# Don't forget to push to HEROKU!!!
