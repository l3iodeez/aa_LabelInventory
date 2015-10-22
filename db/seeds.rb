# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
lyric_text = <<-TEXT
Lorem ipsum dolor sit amet, consectetur adipisicing elit.
Qui dicta minus molestiae vel beatae natus eveniet ratione
emporibus aperiam harum alias officiis assumenda officia
quibusdam deleniti eos cupiditate dolore doloribus!
TEXT



5.times do |i|
  User.create!(email: "user#{i+1}@email.com", password: "password#{i+1}", activation_token: SecureRandom::urlsafe_base64)
end

5.times do |i|
  band = Band.create!(name: "Band#{i+1}")
  5.times do |j|
    album = band.albums.create!(title: "Band#{i+1}'s Album#{j+1}", venue:["studio","live"].sample )
    5.times do |k|
      album.tracks.create!(title: "Band#{i+1} Album#{j+1} Track #{k+1}", bonus:["bonus","regular"].sample, lyrics: lyric_text)
    end
  end
end
