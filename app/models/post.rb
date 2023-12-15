class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags #多対多　post_tagsを経由してtagsにマッチ

  validates :image, presence: true
  validates :caption,length:{maximum:200} #200文字まで

  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user) #user_idがfavoriteテーブルに存在するか確認
    favorites.exists?(user_id: user.id)
  end

  def save_tags(savepost_tags) #タグ機能
    current_tags = self.tags.pluck(:tagname) unless self.tags.nil? #タグが存在していればタグの名前を配列として全て取得。存在していなかったらなにもしない
    old_tags = current_tags - savepost_tags #今postが持っているタグから保存されたタグを除いて(-引く)old_tagsとする。古いタグ(old_tags)は消す
    new_tags = savepost_tags - current_tags #今回保存されたもの(savepost_tag)と現在存在するタグ(current_tags)を除いたタグをnew_tagとする。新しいタグ(new-tags)は保存
		#↑投稿したpostのタグの有無をチェック存在しているものは消す新しいタグは保存

    # Destroy old taggings: (古いタグを消す)
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tagname:old_name)
    end

    # Create new taggings: （新しいタグを保存）
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tagname:new_name)
      # 配列に保存
      self.tags << post_tag
    end
  end

  def self.search_for(content, method) #検索(Postのcaption)
    if method == 'perfect' #完全一致
      Post.where(caption: content)
    else #部分一致
      Post.where('caption LIKE ?', '%'+content+'%')
    end
  end


end
