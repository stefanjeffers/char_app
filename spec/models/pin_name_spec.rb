require 'spec_helper'

describe PinName do

  before { @pin_name = PinName.new( base: "122", offset: "2", pinyin: "hu3", name_word: "tiger", name_word_abrev: "T", part_of_speech: "noun") }

  subject { @pin_name }

  it { should respond_to(:pinyin) }
  it { should respond_to(:name_word) }
  it { should respond_to(:name_word_abrev) }
  it { should respond_to(:part_of_speech) }

  describe "when pinyin is not present" do
    before { @pin_name.pinyin = " " }
    it { should_not be_valid }
  end

  describe "when pinyin is too long" do
    before { @pin_name.pinyin = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when name_word is not present" do
    before { @pin_name.name_word = " " }
    it { should_not be_valid }
  end

  describe "when name_word is too long" do
    before { @pin_name.name_word = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when name_word_abrev is not present" do
    before { @pin_name.name_word_abrev = " " }
    it { should_not be_valid }
  end

  describe "when name_word_abrev is too long" do
    before { @pin_name.name_word_abrev = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when part_of_speech is not present" do
    before { @pin_name.part_of_speech = " " }
    it { should_not be_valid }
  end

  describe "when part_of_speech is too long" do
    before { @pin_name.part_of_speech = "a" * 51 }
    it { should_not be_valid }
  end

end

