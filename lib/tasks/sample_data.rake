namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Circle.create!(
    name: "Example circle",
    )

    circles = Circle.all

    circles.each do |circle|
        20.times do |n|
          name = Faker::Japanese::Name.name
          gender =true

          circle.players.create!(
          name: name,
          gender: gender
          )
      end
    end

    circles.each do |circle|
        20.times do |n|
          name = Faker::Japanese::Name.name
          gender = false

          circle.players.create!(
          name: name,
          gender: gender
          )
      end
    end
  end
end
