class DescriptionsController < ApplicationController
  def new
    @description = Description.new
    @user = User.find params[:user_id]
  end

  def create
    @description = Description.new(description_params)
    @user = User.find params[:user_id]
    @description.user = @user

    if @description.save
      flash[:success] = "Your description was created."
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def description_params
    params.require(:description).permit(:name)
  end
end
