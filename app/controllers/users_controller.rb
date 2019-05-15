class UsersController < ApplicationController
  include CurrentUser
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:new, :create]
  before_action :check_if_current_user, only: [:edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @pets = @user.pets
    @current_user = User.find(session[:user_id])

    @is_current_user = @user == @current_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.is_current_user(session[:user_id])
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      puts "CANNOT UPDATE ANOTHER USER"
      redirect_to welcome_index_url, notice: 'Cannot update another users data.'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.is_current_user(session[:user_id])
      @user.destroy
      session[:user_id] = nil
      redirect_to welcome_index_url
    else
      puts "CANNOT DELETE ANOTHER USER"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :profile_image)
    end

   
end
