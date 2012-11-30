namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    # make_pinnames
    # make_formulas
    make_microposts
    make_relationships
  end
end

def make_users

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
end

def make_microposts
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
end

def make_pinnames
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

def make_formulas
    99.times do |n|
      base = n + 1 
      offset = 99 - n
      subindex = 0
      iform = "#{base} * #{offset}"
      word_form = "first-word * second-word"
      abbrev_form = "FW * SW"
      alpha = "FWASW" 

      Formula.create!(
          base:              base,
          offset:            offset,
          subindex:          subindex,
          iform:             iform,
          word_form:         word_form,
          abbrev_form:       abbrev_form,
          alpha:             alpha )
    end
end

def make_relationships
  users = User.all
  user  = users.first
  # followed_users = users[2..50]
  # followers      = users[3..40]
  followed_users = users[4..52]  # Skip Joe, Moe
  followers      = users[5..42]  # etc.
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end


