# Fakerの設定を日本語に変更
Faker::Config.locale = :ja

unless Rails.env.production?
  # 200件のデータを用意する
  POST_MAX = 200
  post_attrs = Proc.new do
    Array.new(POST_MAX) do |idx|
      { id: idx 1,
        # Fakerを使って文言を用意
        caption: Faker::Lorem.paragraph,
        user_id: User.pluck(:id).sample
      }
    end
  end

  # 配列を一度に登録する(一度だけ)
  Post.seed_once(:id, *post_attrs.call)

  # 追加したレコードに画像を追加
  Post.all.each do |p|
    unless p.image.attached?
      p.image.attach(io: File.open("db/fixtures/images/post/#{Random.rand(1..6)}.jpg"), filename: "#{Random.rand(1..6)}.jpg")
    end
  end

end