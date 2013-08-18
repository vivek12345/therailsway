class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index,:edit, :update,:show]
  before_filter :admin_user,     only: :destroy
  
  def new
  	@user=User.new
  end
  def show
  	@user=User.find(params[:id])
    @posts=@user.posts.paginate(page:params[:page])
    #flash[:success]="Welcome to mysite #{@user.name}"
  end
  def create
  	@user=User.new(params[:user])
  	if @user.save
  		flash[:success]="Welcome to sample app"
  		redirect_to @user
  	else
  		render 'new'
  	end

  end
  def edit
    @user=User.find(params[:id])
    
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success]="Profile updated"
      sign_in @user
      redirect_to @user
  else
    render 'edit'
  end
  end
  def index
    @users = User.paginate(page: params[:page],:per_page => 3, :order => 'name ASC')
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  private

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
