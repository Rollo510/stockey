class UsersController < ApplicationController

	get "/users/signup" do
		erb :'users/signup'
	end

	get '/users/login' do
		erb :'users/login'
	end

	post "/users/signup" do
		user = User.new(username:params[:username], email:params[:email], password:params[:password])
		if user.valid? && user.save
			session[:user_id] = user.id
			redirect to '/stocks'
		else
			redirect to '/failure'
		end
	end

	post "/users/login" do
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect to '/stocks'
		else
			redirect to '/failure'
		end
	end

	get "/failure" do
		erb :'/users/failure'  #todo: build failure page in Users
	end

	get "/logout" do 
		session.clear
		redirect to "/"
	end

end
