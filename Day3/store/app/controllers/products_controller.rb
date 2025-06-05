class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :fetch_item, only: %i[ show edit update destroy ]

  def index
    @items = Product.all
  end

  def show
  end

  def new
    @item = Product.new
  end

  def create
    @item = Product.new(item_parameters)
    if @item.save
      redirect_to @item
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_parameters)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to products_path
  end

  private
    def fetch_item
      @item = Product.find(params[:id])
    end

    def item_parameters
      params.expect(product: [ :name ])
    end
end
