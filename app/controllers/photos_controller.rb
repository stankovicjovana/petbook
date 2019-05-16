class PhotosController < ApplicationController
  include CurrentUser
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :set_pet, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :check_if_owner, only: [:new, :create, :edit, :update, :destroy]
  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
    unless @photo.belongs_to_user(@pet, @user)
      puts "***************************"
      puts "cannot delete photo of other users pets"
      puts "***************************"
      redirect_to @pet, notice: "cannot edit photo of other users pets"
    end
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.pet = @pet
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    if @photo.belongs_to_user(@pet, @user)
      if @photo.update(photo_params)
        redirect_to @photo, notice: 'Photo was successfully updated.' and return
      else
        render :edit and return
      end
    else
      puts "***************************"
      puts "cannot update photo of other users pets"
      puts "***************************"
      redirect_to @pet, notice: "cannot update photo of other users pets"
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    if @photo.belongs_to_user(@pet, @user)
      @photo.pet_image.purge
      @photo.destroy
      respond_to do |format|
        format.html { redirect_to @pet, notice: 'Photo was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      puts "***************************"
      puts "cannot delete photo of other users pets"
      puts "***************************"
      redirect_to @pet, notice: "cannot delete photo of other users pets"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def set_pet
      @pet = Pet.find(session[:pet_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:title, :description, :pet_image)
    end
end
