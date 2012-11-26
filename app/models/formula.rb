# == Schema Information
#
# Table name: formulas
#
#  id          :integer          not null, primary key
#  base        :string(255)
#  offset      :string(255)
#  subindex    :string(255)
#  iform       :string(255)
#  word_form   :string(255)
#  abbrev_form :string(255)
#  alpha       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Formula < ActiveRecord::Base
      # Think about whether any of these should be accessable:
  attr_accessible :base, :offset, :subindex, :iform, :word_form, :abbrev_form, :alpha

  before_save { self.iform.downcase! }
  before_save { self.abbrev_form.upcase! }
  before_save { self.alpha.upcase! }
  # before_save { |pinname| pinname.pinyin = pinyin.downcase }
  # before_save { |pinname| pinname.name_word_abbrev = name_word_abbrev.upcase }

  VALID_INDEX_REGEX    = /\A\d{1,3}\z/
  VALID_SUBINDEX_REGEX = /\A[a-z0-9]\z/
  VALID_ALPHA_REGEX    = /\A[-'a-zA-Z]*\z/
  # VALID_PINYIN_REGEX = /\A[A-Za-z]{1,6}[01234]\z/

  validates :base,             presence: true, length: { maximum: 3 }, format: { with: VALID_INDEX_REGEX }
  validates :offset,           presence: true, length: { maximum: 3 }, format: { with: VALID_INDEX_REGEX }
  validates :subindex,                         length: { maximum: 1 }, format: { with: VALID_SUBINDEX_REGEX }

  validates :alpha,            format: { with: VALID_ALPHA_REGEX }
  # validates :pinyin,           presence: true, length: { minimum: 2, maximum: 7 }, format: { with: VALID_PINYIN_REGEX }
  # validates :name_word,        presence: true, length: { maximum: 30 }
  # validates :name_word_abbrev, presence: true, length: { maximum: 10 }
  # validates :part_of_speech,   presence: true, length: { maximum: 12 }

end
