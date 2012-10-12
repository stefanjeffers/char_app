require 'spec_helper'

describe Pinname do

  before { @pin_name = Pinname.new( base: "122", offset: "2",
                                    pinyin: "hu3", name_word: "tiger", name_word_abbrev: "T",
                                    part_of_speech: "noun", graph_id: "000") }

  subject { @pin_name }

  it { should respond_to(:base) }
  it { should respond_to(:offset) }
  it { should respond_to(:pinyin) }
  it { should respond_to(:name_word) }
  it { should respond_to(:name_word_abbrev) }
  it { should respond_to(:part_of_speech) }

#___________________________________________________
# Test base:
  
  describe "when base is not present" do
    before { @pin_name.base = " " }
    it { should_not be_valid }
  end

  describe "when base is too long" do
    before { @pin_name.base = "1" * 4 }
    it { should_not be_valid }
  end

  describe "when base format is invalid" do
    it "should be invalid" do
      bases = %w[ a abc 1234 123a 00A ]
      bases.each do |invalid_base|
        @pin_name.base = invalid_base

        # @pin_name.save
        # @pin_name.reload

        @pin_name.should_not be_valid
      end
    end
  end

  describe "when base format is valid" do
    it "should be valid" do
      bases = %w[ 0 000 01 001 1 111 123 99 999 ]
      bases.each do |valid_base|
        @pin_name.base = valid_base

        # @pin_name.save
        # @pin_name.reload

        @pin_name.should be_valid
      end
    end
  end

#___________________________________________________
# Test offset:
  
  describe "when offset is not present" do
    before { @pin_name.offset = " " }
    it { should_not be_valid }
  end

  describe "when offset is too long" do
    before { @pin_name.offset = "1" * 4 }
    it { should_not be_valid }
  end

  describe "when offset format is invalid" do
    it "should be invalid" do
      offsets = %w[ a abc 1234 123a 00A ]
      offsets.each do |invalid_offset|
        @pin_name.offset = invalid_offset

        # @pin_name.save
        # @pin_name.reload

        @pin_name.should_not be_valid
      end
    end
  end

  describe "when offset format is valid" do
    it "should be valid" do
      offsets = %w[ 0 000 01 001 1 111 123 99 999 ]
      offsets.each do |valid_offset|
        @pin_name.offset = valid_offset

        # @pin_name.save
        # @pin_name.reload

        @pin_name.should be_valid
      end
    end
  end

#___________________________________________________
# Test name_word_abbrev:
  
  describe "when name_word_abbrev is not present" do
    before { @pin_name.name_word_abbrev = " " }
    it { should_not be_valid }
  end

  describe "when name_word_abbrev is too long" do
    before { @pin_name.name_word_abbrev = "A" * 11 }
    it { should_not be_valid }
  end

  describe "name_word_abbrev with mixed case" do
    let(:mixed_case_name_word_abbrev) { "TIggER" }

    it "should be saved as all upper-case" do
      @pin_name.name_word_abbrev = mixed_case_name_word_abbrev

      # puts @pin_name.pinyin, @pin_name.name_word_abbrev 

      @pin_name.save
      @pin_name.reload.name_word_abbrev.should == mixed_case_name_word_abbrev.upcase

      # puts @pin_name.pinyin, @pin_name.name_word_abbrev

    end
  end

#___________________________________________________
# Test pinyin:

  describe "when pinyin format is invalid" do
    it "should be invalid" do
      pinyins = %w[ a a11 a00 111 nian nian5 shuang shang22 schuang schuang1 ]
      pinyins.each do |invalid_pinyin|
        @pin_name.pinyin = invalid_pinyin

        # puts @pin_name.pinyin

        # @pin_name.save
        # @pin_name.reload

        @pin_name.should_not be_valid
      end
    end
  end

  describe "when pinyin is not present" do
    before { @pin_name.pinyin = " " }
    it { should_not be_valid }
  end

  describe "when pinyin is too long" do
    before { @pin_name.pinyin = "aaaaaaa1" }
    it { should_not be_valid }
  end
  
  describe "when pinyin is too short" do
    before { @pin_name.pinyin = "a" }
    it { should_not be_valid }
  end

         # later, tighten validations so only correct letters are allowed:
  describe "when pinyin format is valid" do
    it "should be valid" do
      pinyins = %w[ a1 a0 aa2 xxx3 xxxx4 shuang1 xhuang0 xxxxxx1 ]
      pinyins.each do |valid_pinyin|
        @pin_name.pinyin = valid_pinyin

        # @pin_name.save
        # @pin_name.reload

        @pin_name.should be_valid
      end
    end
  end

#  before { @pin_name = Pinname.new( base: "122", offset: "2",
#                                    pinyin: "hu3", name_word: "tiger", name_word_abbrev: "T",
#                                    part_of_speech: "noun", graph_id: "000") }

# 1: If I comment out this one reload line, the error goes away.
# 2: This sequence works fine for the case of the other field, name_word_abbrev,
#      as well in the Users test. 
# 3: These operation (well, save, anyway) work fine using the rails console (after some point).
#      although before that point they didn't. What changed there?
# 4: 
  
  describe "pinyin with mixed case" do
    let(:mixed_case_pinyin) { "Shuang4" }

    it "should be saved as all lower-case" do
      @pin_name.pinyin = mixed_case_pinyin

      # puts @pin_name.pinyin

      @pin_name.save
      @pin_name.reload
      @pin_name.pinyin.should == mixed_case_pinyin.downcase
      # @pin_name.reload.pinyin.should == mixed_case_pinyin.downcase
    end
  end

#___________________________________________________
# Test name_word:
  
  describe "when name_word is not present" do
    before { @pin_name.name_word = " " }
    it { should_not be_valid }
  end

  describe "when name_word is too long" do
    before { @pin_name.name_word = "a" * 31 }
    it { should_not be_valid }
  end

#___________________________________________________
# Test part_of_speech:
  
  describe "when part_of_speech is not present" do
    before { @pin_name.part_of_speech = " " }
    it { should_not be_valid }
  end

  describe "when part_of_speech is too long" do
    before { @pin_name.part_of_speech = "a" * 13 }
    it { should_not be_valid }
  end

#___________________________________________________
  
end

