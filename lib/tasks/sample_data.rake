namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    50.times do |n|
      @circle = Circle.create!(
      name: "Lemon Smash",
      email: "lemon#{n+1}@example.com",
      password: "foobar",
      password_confirmation: "foobar",
      group: "39th 40th 41st"
      )

      circles = Circle.all

      boys39 = %w(たぐ ばん さえき くろ そらぞー くらもん こう いとそー じゃが クリス)
      girls39 = %w(まほ つらこ なつ みひろ こむろ さやか しょうこ ゆりえ りりこ ゆり)

      boys40 = %w(チーズ 田島 もってぃ さとし えのき ちゃん オレンジ たいき ベネ ひかる ミッキー まっきー まえちゃん よしむね もとはし)
      girls40 = %w(ななこ かざね あゆみ わかな さな あいか りな しおりん じゅんな あいりょん えりちゃん まりりん れな わーちゃん あゆちゃん たむたむ)

      boys41 = %w(たくぼ つばさ とおる しもみー わっちゃー せきい あっしー よすけ まーしー すがい けんしん なかじー もりけん まや ペッパー しょう)
      girls41 = %w(ひとみ もこ まゆ ふさえ れいな ひなの あおい りさぽよ くるみ かずよ ゆい ななみ みやち さき)

      def lesma(group, boys, girls)
        @circle.players.create!(
          name: "-",
          gender: "non",
          com: true
        )
        boys.each do |name|
          @circle.players.create!(
          name: name,
          gender: "male",
          group: group,
          active:true
          )
        end
        girls.each do |name|
            @circle.players.create!(
            name: name,
            gender: "female",
            group: group,
            active: true
            )
        end
      end
      lesma("39th", boys39, girls39)
      lesma("40th", boys40, girls40)
      lesma("41st", boys41, girls41)
    end
  end
end
