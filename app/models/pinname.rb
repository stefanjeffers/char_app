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

  has_many :links, foreign_key: "pinname_id", dependent: :destroy
  # don't need the source override?
  # has_many :formulas, through: :links, source: :formula
  has_many :formulas, through: :links

  before_save { self.pinyin.downcase! }
  before_save { self.name_word_abbrev.upcase! }
  # before_save { |pinname| pinname.pinyin = pinyin.downcase }
  # before_save { |pinname| pinname.name_word_abbrev = name_word_abbrev.upcase }

  VALID_INDEX_REGEX = /\A\d{1,3}\z/
  # VALID_PINYIN_REGEX = /\A[a-z]{1,6}[01234]\z/
  # If we only allow lower case here, then validations won't allow save/reload in tests.
  # VALID_PINYIN_REGEX = /\A[A-Za-z]{1,6}[01234]\z/

  validates :base,             presence: true, length: { maximum: 3 }, format: { with: VALID_INDEX_REGEX }
  validates :offset,           presence: true, length: { maximum: 3 }, format: { with: VALID_INDEX_REGEX }
  # validates :pinyin,           presence: true, length: { minimum: 2, maximum: 7 }, format: { with: VALID_PINYIN_REGEX }
  validates :pinyin,           presence: true, length: { minimum: 2, maximum: 7 }
  validates :name_word,        presence: true, length: { maximum: 30 }
  validates :name_word_abbrev, presence: true, length: { maximum: 10 }
  validates :part_of_speech,   presence: true, length: { maximum: 12 }

  def linked_to?(formula)
    self.links.find_by_formula_id(formula.id)
  end

  def link_to!(formula)
    self.links.create!(formula_id: formula.id)
  end

  def unlink!(formula)
    self.links.find_by_formula_id(formula.id).destroy
  end

  def self.search_pinyin(search)
    if search
      # find(:all, :conditions => ['Pinnames.pinyin LIKE ?', "%#{search}%"])
      find(:all, :conditions => ['pinyin LIKE ?', "%#{search}%"])
    else
      # find(:all)
      find(:all, :conditions => ['pinyin LIKE ?', "%n/a%"])
    end
  end

  def self.search_alpha(search)
    if search
      formulas.find(:all, :conditions => ['alpha LIKE ?', "%#{search}%"])
    else
      formulas.find(:all)
    end
  end

end
