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
    sequence(:content)  { |n| "Lorem ipsum #{n}" }
    # content "Lorem ipsum"
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

  factory :formula do
    # base         "035"
    sequence(:base)  { |n| "#{n}" }
    # offset       "031"
    sequence(:offset)  { |n| "#{100-n}" }
    subindex     "0"
    # iform        "35.1 / 68.1"
    sequence(:iform)  { |n| "#{100-n}.#{n} / #{n}.#{100-n}" }
    word_form    "knife / mouth"
    abbrev_form  "K / M"
    alpha        "KOM"
  end
end
