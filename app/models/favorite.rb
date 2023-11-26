class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: {scope: :post_id} #いいねを二回押せないようにする(user_idとpost_idのペアが既にないかチェック)
end
