class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i{index search show create edit update}
  before_action :set_item, only: %i{edit update}
  before_action :set_book, only: %i{show}

  def index
    @items = current_user.items.order(created_at: :desc).page(params[:page])
  end

  def search
    @data = Book.search_for_amazon(params[:keyword], params[:page] ? params[:page].to_i : 1)
    @keyword = params[:keyword]
  end

  def show
  end

  def create
    @book = Book.find_or_create_by(book_paramas)
    @item = current_user.items.build({user_id: current_user.id, book_id: @book.id})
    @item.save!

    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def update
    if (@item.update(item_params))
      flash.notice = '更新しました'
      redirect_to user_items_path
    else
      flash.now.alert = '更新に失敗しました'
      render :edit
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_book
    @book = Book.find_or_create_by_asin(params[:asin])
  end

  def item_params
    params.require(:item).permit(:status, :rank, :category_id,
      :review, tags_attributes: [:id, :name])
  end

  def book_paramas
    params.require(:book).permit(:asin, :title, :author, :price, :publicated_at, :manufacturer, :image)
  end
end
