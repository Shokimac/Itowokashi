class BookmarksController < ApplicationController

  before_action :authenticate_user!

  def index
    @episodeBookmarks = EpisodeBookmark.includes(:user).where(user_id: current_user.id).page(params[:page]).reverse_order
    @proverbBookmarks = ProverbBookmark.includes(:user).where(user_id: current_user.id).page(params[:page]).reverse_order
  end
end