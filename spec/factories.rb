FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end

  factory :pinname do
    # base	"177"
    sequence(:base)  { |n| "#{n}" }
    # offset	"1"
    sequence(:offset)  { |n| "#{100-n}" }
    pinyin      "ma3"
    # name_word   "horse"
    sequence(:name_word)  { |n| "word#{n}" }
    name_word_abbrev "W"
    part_of_speech   "noun"
  end
end

