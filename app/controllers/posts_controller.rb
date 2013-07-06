class PostsController < ApplicationController
	before_filter :signed_in_user, only: [:edit,:update,:destroy,:new]
  def new
  	@post=Post.new
  end

  def show
  	@post=Post.find(params[:id])
    #@posts=Post.paginate(page: params[:page],:per_page => 3,:order=>'created_at DESC')
  end
  def create
  	@post=Post.new(params[:post])
  	if @post.save
  		flash[:success]="Post created successfully"
  		redirect_to @post
  	else
  		flash[:error]="Some error found"
  		render 'new'
  	end
  end
  def edit
  	if signed_in?
  	@post=Post.find(params[:id])
  else
  	flash[:notice]="You need to sign-in first"
  	redirect_to root_url
  end
  end

  def update
  	@post=Post.find(params[:id])
  	if @post.update_attributes(params[:post])
  		flash[:success]="Edited the post"
  		redirect_to root_url
  	else
  		render 'edit'
  	end
  end

  def destroy
  	Post.find(params[:id]).destroy
  	flash[:success]="Deleted the post"
  	redirect_to root_url 

  end
  def index
  	@posts=Post.paginate(page: params[:page],:per_page => 3,:order=>'created_at DESC')
  end

  

  private

    def signed_in_user
      redirect_to root_url, notice: "Please sign in." unless signed_in?
    end





end
