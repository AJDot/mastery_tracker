class DescriptionsController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :update]
  before_action only: [:new, :create, :edit, :update] do
    require_user_owns_page(params[:user_id])
  end

  def new
    @description = Description.new
    @user = User.find_by username: params[:user_id]
  end

  def create
    @description = Description.new(description_params)
    @user = User.find_by username: params[:user_id]
    @description.user = @user

    if @description.save
      flash[:success] = "Your description was created."
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find_by username: params[:user_id]
    @description = Description.find_by token: params[:id]
  end

  def update
    @user = User.find_by username: params[:user_id]
    @description = Description.find_by token: params[:id]

    if @description.update(description_params)
      flash[:success] = "Description updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def description_params
    params.require(:description).permit(:name)
  end
end
