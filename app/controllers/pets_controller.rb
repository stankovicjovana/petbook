class PetsController < ApplicationController
  include CurrentUser
  before_action :set_pet, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :show, :edit, :create, :update, :destroy]
  before_action :check_if_owner, only: [:edit, :update, :destroy]
  before_action :set_all_pets, only: [:index, :new, :edit, :create, :update]
  after_action :check_animal_type, only: [:create, :update]
  # GET /pets
  # GET /pets.json
  def index
    
  end

  # GET /pets/1
  # GET /pets/1.json
  def show
    session[:pet_id] = @pet.id
  end

  # GET /pets/new
  def new
    @pet = Pet.new
  end

  # GET /pets/1/edit
  def edit
    
  end

  # POST /pets
  # POST /pets.json
  def create 
    @pet = Pet.new(pet_params)
    @pet.user = @user
    
    respond_to do |format|
      if @pet.save
        format.html { redirect_to @pet, notice: 'Pet was successfully created.' }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to @pet, notice: 'Pet was successfully updated.' }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1
  # DELETE /pets/1.json
  def destroy
    session[:pet_id] = nil
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_url, notice: 'Pet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pet_params
      params.require(:pet).permit(:name, :description, :animal_type, :breed, :user_id, :parent_id)
    end

    def set_all_pets
      @pets = Pet.all
    end

    def check_animal_type
      if @pet.has_parent?
        unless @pet.same_type(@pet.parent.animal_type)
          @pet.parent_id = nil
          @pet.save
          puts "********"
          puts "not same type"
          puts "********"
        end
      end
      
    end

end
