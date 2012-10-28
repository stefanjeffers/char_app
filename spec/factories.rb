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

  factory :pinname do
    base	"177"
    offset	"1"
    pinyin      "ma3"
    name_word   "horse"
    name_word_abbrev "H"
    part_of_speech   "noun"
  end
end

