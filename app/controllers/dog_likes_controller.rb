class DogLikesController < ApplicationController
  before_action :set_dog
  after_action :verify_authorized

  def create
    authorize @dog, :like?

    if Like.find_or_create_by(dog_id: @dog.id, user_id: current_user.id)
      redirect_to dogs_path
    else
      #raise error
    end
  end

  def destroy
    authorize @dog, :like?

    like = Like.find_by(dog_id: @dog.id, user_id: current_user.id)

    if like && like.delete 
      redirect_to dogs_path
    else
      #raise error
    end
  end

  private

  def set_dog
    @dog = Dog.find(params[:dog_id])
  end
end
