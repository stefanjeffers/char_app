FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
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

