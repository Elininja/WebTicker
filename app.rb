# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require
require './models/Ticker'

enable :sessions

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
  puts 'Checking user variable'
  if @registered_teacher
    puts 'teacher'
    @lists = @registered_teacher.lists.all
    erb :teacherpage
  elsif @registered_student
    puts 'student'
    @lists = @registered_student.lists.all
    erb :waitingroom
  else
    puts 'neither'
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
    puts 'user.name = ...'
    puts '...' + user.name
    session[:name] = user.name
    puts 'foo'
    redirect '/'

  else
    # if the password doesn't match our stored hash,
    # show a nice error page
    @message = "Incorrect password."
    erb :message_page
  end
end

post '/new_student' do
  @student = Student.create(params)
  if @student.valid?
    session[:name] = @student.name
    @message = 'Success! Your new Student Account has been created.'
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
    @message = 'Success! Your new Teacher Account has been created.'
    erb :message_page
  else
    @message = @teacher.errors.full_messages.join(', ')
    erb :message_page
  end
end

get '/logout' do
  session.clear
  @message = 'You have successfully logged out! See you next time.'
  erb :message_page
end

# TODO
# Don't forget to push to HEROKU!!!
