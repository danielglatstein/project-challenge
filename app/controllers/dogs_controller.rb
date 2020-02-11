class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show]

  # GET /dogs
  # GET /dogs.json
  def index
    @sorted_by_likes = sort_by_likes?
    @dogs = begin
      if sort_by_likes?
        Dog.includes(:owner).page(page_param).sorted_by_likes_in_past_hour
      else
        Dog.includes(:owner).page(page_param)
      end
    end
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show; end

  # GET /dogs/new
  def new
    @dog = Dog.new

    authorize @dog
  end

  # GET /dogs/1/edit
  def edit
    authorize @dog
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params)
    authorize @dog
    
    respond_to do |format|
      if @dog.save
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: "#{@dog.name.capitalize}'s profile was successfully created." }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    authorize @dog

    respond_to do |format|
      if @dog.update(dog_params)
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: "#{@dog.name.capitalize}'s profile was successfully updated." }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    authorize @dog
    dog_name = @dog.name.capitalize
    @dog.destroy
    
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: "#{dog_name}'s profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def sort_by_likes?
    params[:sort] == "likes"
  end

  def page_param
    permitted_params = params.permit!
    permitted_params[:page]
  end

  def dog_params
    params.require(:dog).permit(:name, :description, :images, :user_id)
  end
end
