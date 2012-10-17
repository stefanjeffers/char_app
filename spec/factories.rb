FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :pinname do
    base	"100"
    offset	"2"
    pinyin      "pian4"
    name_word   "test"
    name_word_abbrev "T"
    part_of_speech   "noun"
  end
end

