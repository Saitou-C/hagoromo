# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
 admin.password = ENV['ADMIN_PASSWORD']
end


#テストデータ
mika = User.find_or_create_by!(email: "mika@example.com") do |user|
  user.name = "みか"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

saitou = User.find_or_create_by!(email: "saitou@example.com") do |user|
  user.name = "サイトウ"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
  user.introduction = "着物初心者ですがよろしくお願いします。"
end

ayaka = User.find_or_create_by!(email: "ayaka@example.com") do |user|
  user.name = "Ayaka"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
  user.introduction = "はじめたばかりです。"
end

tag_names = ["初詣", "浴衣", "卒業式", "振袖", "成人式", "前撮り"]
#タグ　= 0,1,2,3,4,5

tag_names.each do |tag_name|
  Tag.find_or_create_by(tagname: tag_name)
end


Post.find_or_create_by!(caption: "本日のコーデ。初詣に行ってきました！") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.user = mika

  tag = Tag.find_or_create_by(tagname: tag_names[0])
  post.tags << tag
end

Post.find_or_create_by!(caption: "大学の卒業式でした。振袖は成人式のものに袴はレンタルしました。記念すべき日に晴れて良かったです。") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.user = saitou

  tag_names[2..3].each do |tag_name|
    tag = Tag.find_or_create_by(tagname: tag_name)
    post.tags << tag
  end
end

Post.find_or_create_by!(caption: "今年の夏来た浴衣の写真！来年はどんな浴衣を着ようかな〜") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.user = saitou

  tag = Tag.find_or_create_by(tagname: tag_names[1])
  post.tags << tag
end

Post.find_or_create_by!(caption: "成人式の前撮り！") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")
  post.user = ayaka

  tag_names[3..5].each do |tag_name|
    tag = Tag.find_or_create_by(tagname: tag_name)
    post.tags << tag
  end
end

