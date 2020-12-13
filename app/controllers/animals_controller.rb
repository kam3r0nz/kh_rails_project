class AnimalsController < ApplicationController
    before_action :require_login
    
    def index
        @animals = Animal.all
    end

    def new
        @animal = Animal.new
    end

    def create
        @animal = current_user.animals.new(animal_params)
        if @animal.save
            redirect_to animal_path(@animal)
        end
    end

    def show
        @animal = Animal.find_by(id: params[:id])
    end

    private

    def animal_params
        params.require(:animal).permit(:name, :age, :color, :species, :image)
    end
end