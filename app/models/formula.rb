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
  attr_accessible :graph_id, :base, :offset, :subindex, :ord, :iform, :word_form, :abbrev_form, :alpha

  has_many :reverse_links, foreign_key: "formula_id", class_name: "Link", dependent: :destroy
  # don't need the source override?
  # has_many :pinnames, through: :reverse_links, source: :pinname
  has_many :pinnames, through: :reverse_links

  before_save { self.iform.downcase! }
  before_save { self.abbrev_form.upcase! }
  before_save { self.alpha.upcase! }

  VALID_INDEX_REGEX    = /\A\d{1,3}\z/
  VALID_SUBINDEX_REGEX = /\A[a-z0-9]\z/
  VALID_ALPHA_REGEX    = /\A[-'a-zA-Z]*\z/

  validates :base,             presence: true, length: { maximum: 3 }, format: { with: VALID_INDEX_REGEX }
  validates :offset,           presence: true, length: { maximum: 3 }, format: { with: VALID_INDEX_REGEX }
  validates :subindex,                         length: { maximum: 1 }, format: { with: VALID_SUBINDEX_REGEX }

  validates :iform,            presence: true
  validates :word_form,        presence: true
  validates :abbrev_form,      presence: true
  validates :alpha,            presence: true, format: { with: VALID_ALPHA_REGEX }
  # validates :pinyin,           presence: true, length: { minimum: 2, maximum: 7 }, format: { with: VALID_PINYIN_REGEX }
  # validates :name_word,        presence: true, length: { maximum: 30 }

  def linked_to?(pinname)
    self.reverse_links.find_by_pinname_id(pinname.id)
    # Pinname.links.find_by_pinname_id(pinname.id)
  end

  def link_to!(pinname)
    self.reverse_links.create!(pinname_id: pinname.id)
    # Pinname.links.create!(pinname_id: pinname.id)
  end

  def unlink!(pinname)
    self.reverse_links.find_by_pinname_id(pinname.id).destroy
    # Pinname.links.find_by_pinname_id(pinname.id).destroy
  end

end
