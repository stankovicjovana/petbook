class PostsController < ApplicationController
  include CurrentUser
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :show, :edit, :create, :update, :destroy]
  before_action :check_if_current_user, only: [:new, :edit, :create, :update, :destroy]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = @user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @user, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.does_belongs_to(@user)
        if @post.update(post_params)
          redirect_to @user, notice: 'Post was successfully updated.' and return 
        else
          render :edit and return 
        end
    else 
        puts "CANNOT UPDATE OTHER USER POSTS"
        redirect_to @user, notice: "Can not update post of another user."
    end
  end
  

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if @post.does_belongs_to(@user)
      @post.destroy
      respond_to do |format|
        format.html { redirect_to @user, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      puts "CANNOT DESTROY OTHER USER POSTS"
      redirect_to @user, notice: "Can not delete post of another user."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:body, :users_photo)
    end
end
