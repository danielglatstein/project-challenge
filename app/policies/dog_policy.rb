class DogPolicy
  attr_reader :user, :dog

  def initialize(user, dog)
    @user = user
    @dog = dog
  end

  def new?
    user.present?
  end

  alias_method :create?, :new?

  def edit?
    dog.owner == user
  end

  alias_method :update?, :edit?
  alias_method :destroy?, :edit?

  def like?
    user.present? && 
      dog.owner != user
  end
end
