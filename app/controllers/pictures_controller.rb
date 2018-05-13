class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :login_check, only: [:new, :show, :edit, :update, :destroy]

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render :new if @picture.invalid?
  end

  def index
    @pictures = Picture.all
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
      @picture.image.retrieve_from_cache! params[:cache][:image]
    else
      @picture = Picture.new
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"投稿を削除しました！"
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "投稿を編集しました！"
    else
      render 'edit'
    end
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    @picture.image.retrieve_from_cache!  params[:cache][:image]
    if @picture.save
      redirect_to pictures_path, notice: "投稿しました！"
      NoticeMailer.send_mail_picture(@picture, @picture.user.email).deliver
    else
      render 'new'
    end
  end

  private
    def picture_params
      params.require(:picture).permit(:title, :content, :image, :image_cache)
    end

    def set_picture
      @picture = Picture.find(params[:id])
    end

    def login_check
      if !current_user
        render("/sessions/new")
      end
    end

end
