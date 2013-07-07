class SessionsController < ApplicationController
	def new
	end
	def create
		user=User.find_by_email(params[:sessions][:email])
		if user && user.authenticate(params[:sessions][:password])
			sign_in user
			flash.now[:success]="Welcome to sample app"
			redirect_to root_url
		else
			flash[:error]="Invalid username/password"
			redirect_to root_url
		end			
	end

	def destroy
		self.current_user=nil
		cookies.delete(:remember_token)
		flash[:success]="Successfully signed-out"
		redirect_to root_url
	end
	def sign_in(user)
		cookies.permanent[:remember_token]=user.remember_token
		self.current_user=user
	end
	def current_user=(user)
    @current_user = user
    end

  	def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  	end
	def signed_in?
		!current_user.nil?
	end

end
