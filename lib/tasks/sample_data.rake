namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Circle.create!(
    name: "レモンスマッシュ",
    )

    circles = Circle.all

    boys = %w(たぐ ばん さえき くろ そらぞー くらもん こう いとそー)
    girls = %w(まほ つらこ なつ みひろ こむろ さやか しょうこ)

    circles.each do |circle|
      circle.players.create!(
        name: "-",
        gender: "non",
        com: true
      )
      boys.each do |name|
        gender = "male"
        circle.players.create!(
        name: name,
        gender: gender,
        active:true
        )
      end
      girls.each do |name|
          gender = "female"

          circle.players.create!(
          name: name,
          gender: gender,
          active: true
          )
      end
    end
  end
end
