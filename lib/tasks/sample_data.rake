namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    50.times do |n|
      @circle = Circle.create!(
      name: "Lemon Smash",
      email: "lemon2016-#{n+1}@example.com",
      password: "satoshi",
      password_confirmation: "satoshi",
      group: "39th 40th 41st 42nd"
      )

      circles = Circle.all

      boys39 = %w(たぐ ばん さえき くろ そらぞー くらもん こう いとそー じゃが クリス)
      girls39 = %w(まほ つらこ なつ みひろ こむろ さやか しょうこ ゆりえ りりこ ゆり)

      boys40 = %w(チーズ 田島 もってぃ さとし えのき ちゃん オレンジ たいき ベネ ひかる ミッキー まっきー まえちゃん よしむね もとはし)
      girls40 = %w(ななこ かざね あゆみ わかな さな あいか りな しおりん じゅんな あいりょん えりちゃん まりりん れな わーちゃん あゆちゃん たむたむ)

      boys41 = %w(たくぼ つばさ とおる しもみー わっちゃー せきい あっしー よすけ まーしー すがい けんしん なかじー もりけん まや ペッパー しょう)
      girls41 = %w(ひとみ もこ まゆ ふさえ れいな ひなの あおい りさぽよ くるみ かずよ ゆい ななみ みやち さき)

      boys42=%w(ホライズン りゅー サック サイトシン みやぴー たっちゃん トシ 総理 ザキ SG ケイ ヨネ マツコ ハル トニック りょう しもD ラモス のっち やっぴ うっしー はまー そうすけ まさたけ ぴろゆき ハーマイオニー 大崎大樹 マッソスポンディルス 安田広大 クマ)
      girls42 =%w(ミサ 高原りな ななちょす いとぅん なな みずき 松下さや みぃみ みさみさ みさちん まみな さとあや きしこ かな あまみ マシュー あきか はるこ ふーちゃん もりも あみ りなみ もも キャサリン わかちゃん たんたん うな まりん きみこ 戸村咲希子 まみたん 瀧川なつき こま)

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
      lesma("42nd", boys42, girls42)
    end
  end
end
