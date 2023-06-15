class ListsController < ApplicationController
  before_action :set_list, only: %I[show]
  def index
    @lists = List.all
  end

  def show
    @bookmarks = Bookmark.where("list_id = #{params[:id]}")
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.valid?
      @list.save!
      redirect_to list_path(@list)
    else
      render 'lists/new', status: :unprocessable_entity
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
