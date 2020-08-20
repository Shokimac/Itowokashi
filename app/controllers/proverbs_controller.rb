class ProverbsController < ApplicationController
  def new
    @proverb = Proverb.new
  end

  def create
    @proverb = Proverb.new(proverb_params)
    @proverb.user_id = current_user.id
    @proverb.save
    redirect_to proverbs_path
  end

  def index
    @proverbs = Proverb.all.page(params[:page]).reverse_order
    @user = User.find(current_user.id)
    favorite_count = Proverb.joins(:proverb_favorites).group(:proverb_id).count
    favorited_ids = Hash[favorite_count.sort_by{ |_, v| -v }].keys
    @all_rank = Proverb.where(id: favorited_ids).limit(5)
  end

  def show
    @proverb = Proverb.find(params[:id])
    @user = User.find(@proverb.user_id)
    @comment = PostComment.new
    @post_comments = PostComment.where(proverb_id: @proverb.id)
  end

  def edit
    @proverb = Proverb.find(params[:id])
  end

  def update
    @proverb = Proverb.find(params[:id])
    @proverb.update(proverb_params)
    redirect_to proverb_path(@proverb)
  end

  def destroy
    @proverb = Proverb.find(params[:id])
    @proverb.destroy
    redirect_to proverbs_path
  end

  private

  def proverb_params
    params.require(:proverb).permit(:body, :name, :introduction)
  end
end
