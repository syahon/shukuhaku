User.create!(
  user_name: "first",
  mail: "first@example.com",
  password: "password",
  password_confirmation: "password"
)

3.times do |n|
  name = Faker::Name.name
  mail = "user#{n+1}@example.com"
  password = "password"
  User.create!(
    user_name: name,
    mail: mail,
    password: password,
    password_confirmation: password
  )
end

def create_rooms(area)
  users = User.all

  10.times do
    users.each do |user|
      name = area + Faker::Lorem.sentence
      introduction = Faker::Lorem.sentence
      address = area
      price = Faker::Number.within(range: 3000..10000)
      user.rooms.create!(
        room_name: name,
        introduction: introduction,
        address: address,
        price: price,
        image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/room01.jpeg')),
                                                          filename:"room01.jpeg", content_type: "image/jpeg")
      )
    end
  end
end

create_rooms("東京")
create_rooms("大阪")
create_rooms("京都")
create_rooms("札幌")
