class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id' #tagが削除されたらpost_tagsも消える,tag_id制約
  has_many :posts, through: :post_tags #多対多　post_tagsを経由してpostsとマッチ
  
  validates :tagname, presence:true, length:{maximum:50} #空文字は許可しない、最大50文字まで
  
  scope :merge_posts, -> (tags){ } #タグ合体（？？？？
  
  def self.search_posts_for(content, method)
    
    if method == 'perfect'
      tags = Tag.where(tagname: content)
    elsif method == 'forward'
      tags = Tag.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('name LIKE ?', '%' + content)
    else
      tags = Tag.where('name LIKE ?', '%' + content + '%')
    end
    
    return tags.inject(init = []) {|result, tag| result + tag.posts}
    
  end
  
end
