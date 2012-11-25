# == Schema Information
#
# Table name: pinnames
#
#  id               :integer          not null, primary key
#  base             :string(255)
#  offset           :string(255)
#  subindex         :string(255)
#  ord              :string(255)
#  pinyin           :string(255)
#  name_word        :string(255)
#  name_word_abbrev :string(255)
#  part_of_speech   :string(255)
#  graph_id         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Pinname < ActiveRecord::Base
      # Think about whether any of these should be accessable:
  attr_accessible :base, :graph_id, :name_word, :name_word_abbrev, :offset, :ord, :part_of_speech, :pinyin, :subindex

  before_save { self.pinyin.downcase! }
  before_save { self.name_word_abbrev.upcase! }
  # before_save { |pinname| pinname.pinyin = pinyin.downcase }
  # before_save { |pinname| pinname.name_word_abbrev = name_word_abbrev.upcase }

  VALID_INDEX_REGEX = /\A\d{1,3}\z/
  # VALID_PINYIN_REGEX = /\A[a-z]{1,6}[01234]\z/
  # If we only allow lower case here, then validations won't allow save/reload in tests.
  VALID_PINYIN_REGEX = /\A[A-Za-z]{1,6}[01234]\z/

  validates :base,             presence: true, length: { maximum: 3 }, format: { with: VALID_INDEX_REGEX }
  validates :offset,           presence: true, length: { maximum: 3 }, format: { with: VALID_INDEX_REGEX }
  validates :pinyin,           presence: true, length: { minimum: 2, maximum: 7 }, format: { with: VALID_PINYIN_REGEX }
  validates :name_word,        presence: true, length: { maximum: 30 }
  validates :name_word_abbrev, presence: true, length: { maximum: 10 }
  validates :part_of_speech,   presence: true, length: { maximum: 12 }

end
