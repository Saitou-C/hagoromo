# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Admin.find_or_create_by!(
  #admin.email = ENV['ADMIN_EMAIL'], ## 任意のメールアドレス,
  #admin.encrypted_password = ENV['ADMIN_PASSWORD'] ## 任意のパスワード
#)

Admin.find_or_create_by(id: 1) do |admin|
 admin.email = ENV['ADMIN_EMAIL']
 admin.encrypted_password = ENV['ADMIN_PASSWORD']
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

Post.find_or_create_by!(caption: "本日のコーデ。初詣に行ってきました！") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.tags.tagname = "初詣"
  post.user = mika
end

Post.find_or_create_by! do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.caption = "大学の卒業式でした。振袖は成人式のものに袴はレンタルしました。記念すべき日に晴れて良かったです。"
  post.tags = "卒業式"
  post.user = saitou
end

Post.find_or_create_by! do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.caption = "今年の夏来た浴衣の写真！来年はどんな浴衣を着ようかな〜"
  post.tags = "浴衣"
  post.user = saitou
end

Post.find_or_create_by! do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")
  post.caption = "成人式の前撮り！"
  post.tags = "成人式"
  post.user = ayaka
end