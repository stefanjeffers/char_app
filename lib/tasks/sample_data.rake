namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)

    User.create!(name: "joe",
                 email: "joe@joe.com",
                 password: "joejoe",
                 password_confirmation: "joejoe")

    User.create!(name: "moe",
                 email: "moe@moe.com",
                 password: "moemoe",
                 password_confirmation: "moemoe")

    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    99.times do |n|
      base = n + 1 
      offset = 99 - n
      pinyin = "ji1"
      name_word  =  "word#{n+1}"
      name_word_abbrev = "W#{n+1}"
      part_of_speech = "noun"
      Pinname.create!(
          base:              base,
          offset:            offset,
          pinyin:            pinyin,
          name_word:         name_word,
          name_word_abbrev:  name_word_abbrev,
          part_of_speech:    part_of_speech )
    end
  end
end

