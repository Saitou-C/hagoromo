class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id' #tagが削除されたらpost_tagsも消える,tag_id制約
  has_many :posts, through: :post_tags #多対多　post_tagsを経由してpostsとマッチ

  validates :tagname, presence:true, length:{maximum:50} #空文字は許可しない、最大50文字まで



  def self.search_posts_for(content, method) #検索分岐

    if method == 'perfect' #完全一致
      tags = Tag.where(tagname: content)
    else #部分一致
      tags = Tag.where('tagname LIKE ?', '%' + content + '%')
    end

    return tags.inject(init = []) {|result, tag| result + tag.posts} #タグ繰り返し

  end

end
