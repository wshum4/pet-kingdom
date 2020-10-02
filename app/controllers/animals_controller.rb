class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy]

  def index
    @animals = policy_scope(Animal)
    @animal = Animal.new
    # authorize(@animal)
    # can only display list of animals belong to owner
    if current_user.owner
      @animals = @animals.where(owner_id: current_user.id)
    end
  end

  def show
    # @animal = Animal.find(params[:id])
    @requests = @animal.requests
    @requests = @requests.map { |request| request.sitter_id == current_user.id }
    authorize(@animal)
    if current_user == @animal.owner || current_user == @requests.first.sitter
    # if @animal = Animal.find_by(owner_id: current_user.id) || @animal = Animal.find_by(requests.first.sitter_id == current_user.id)
    # if @animal = Animal.joins(requests: :sitter).where(requests.sitter_id = current_user.id) || Animal.where(owner_id: current_user.id)
      @animal
    else
      flash[:alert] = "You are not authorized to see this page."
      redirect_to(root_path)
    end
  end

  def new
    @animal = Animal.new
    authorize(@animal)
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.owner = current_user
    authorize(@animal)
    if @animal.save
      redirect_to animals_path
    else
      render 'new'
    end
  end

  def edit
    # @animal = Animal.find(params[:id])
    authorize(@animal)
  end

  def update
    @animal = Animal.find(params[:id])
    authorize(@animal)
    @animal.update(animal_params)
    if @animal.save
      redirect_to animal_path(@animal)
    else
      render 'show'
    end
  end

  def destroy
    # @animal = Animal.find(params[:id])
    authorize(@animal)
    @animal.destroy
    redirect_to animals_path
  end

  private

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:owner_id, :name, :age, :description, :photo)
  end
end
