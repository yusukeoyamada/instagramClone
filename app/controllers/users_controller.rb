class UsersController < ApplicationController

  before_action :set_user_infomation, only: [:edit, :update]

  def new
    if params[:back]
      @user = User.new(user_params)
      @user.icon_image.retrieve_from_cache! params[:cache][:icon_image]
    else
      @user = User.new
    end
  end

  def confirm
    @user = User.new(user_params)
    render :new if @user.invalid?
  end

  def show
    @user = User.find(params[:id])
    @favorites_pictures = @user.favorite_pictures.all
  end

  def create
    @user = User.new(user_params)
    @user.icon_image.retrieve_from_cache!  params[:cache][:image]
    if @user.save
      redirect_to new_session_path, notice:"新たにユーザー情報を登録しました！"
    else
      render'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "ユーザー情報を編集しました！"
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon_image, :icon_image_cache)
    end

    def set_user_infomation
      @user = User.find(params[:id])
    end
end
