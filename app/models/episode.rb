class Episode < ApplicationRecord
    belongs_to :user

    has_many :episode_favorites
    has_many :episode_bookmarks
    
    def favorited_by?(user)
        episode_favorites.where(user_id: user.id).exists?
    end
end
