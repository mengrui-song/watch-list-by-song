class ListsController < ApplicationController
  def index
    @lists = policy_scope(List) # policy is for index and I dont need aurhorize because of policy.
  end

  def show
    @list = List.find(params[:id])
    @movies = @list.movies
    authorize @list
  end

  def new
    @list = List.new
    authorize @list
  end

  def create
    @list = List.new(list_params)
    authorize @list
    @list.user = current_user
    if @list.save
      redirect_to lists_path
    else
      render :new
    end
  end

  def destroy
    @list = List.find(params[:id])
    authorize @list
    @list.destroy
    redirect_to lists_path, status: :see_other

  end

  private

  def list_params
    params.require(:list).permit(:name, :image_url, :photo)
  end
end
