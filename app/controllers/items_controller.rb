class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i{index search show create edit update}
  before_action :set_item, only: %i{edit update}
  before_action :set_book, only: %i{show edit update}
  before_action :set_bookshelf, only: %i{index search create}

  def index
    @items = @bookshelf.items.order(created_at: :desc).page(params[:page])
  end

  def search
    @data = Item.search_for_amazon(params[:keyword], params[:page] ? params[:page].to_i : 1)
    @keyword = params[:keyword]
  end

  def show
  end

  def create
    @book = @bookshelf.items.build(book_paramas)
    @book.save!

    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def update
    if (@item.update(item_params))
      flash.notice = '更新しました'
      redirect_to bookshelf_items_path
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
    asin =  params[:asin] ? params[:asin] : @item.asin
    @book = Item.search_for_amazon_by_asin(asin)
  end

  def set_bookshelf
    @bookshelf = current_user.bookshelf
  end

  def item_params
    params.require(:item).permit(:status, :rank, :category_id,
      review_attributes: [:id, :body], tags_attributes: [:id, :name])
  end

  def book_paramas
    params.require(:book).permit(:asin, :image)
  end
end
