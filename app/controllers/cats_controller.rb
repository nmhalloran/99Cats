class CatsController < ApplicationController

  def index
    @kitties = Cat.all
    render :index
  end

  def show
    @kitty = Cat.find(params[:id])

    render :show
  end

  def edit
    @kitty = Cat.find(params[:id])

    render :edit
  end

  def update
    @kitty = Cat.find(params[:id])
    if @kitty.update(cats_params)
      redirect_to cat_url(@kitty)
    else
      render :edit
    end
  end

  def create
    @kitty = Cat.new(cats_params)
    if @kitty.save
      redirect_to cat_url(@kitty)
    else
      render :new
    end
  end

  def new
    @kitty = Cat.new()
    render :new
  end

  private
  def cats_params
    params.require(:cats).permit(:name, :birth_date, :sex, :color, :description)
  end
end
