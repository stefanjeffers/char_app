# == Schema Information
#
# Table name: pin_names
#
#  id              :integer          not null, primary key
#  base            :string(255)
#  offset          :string(255)
#  subindex        :string(255)
#  ord             :string(255)
#  pinyin          :string(255)
#  name_word       :string(255)
#  name_word_abrev :string(255)
#  part_of_speech  :string(255)
#  graph_id        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class PinName < ActiveRecord::Base
  attr_accessible :base, :graph_id, :name_word, :name_word_abrev, :offset, :ord, :part_of_speech, :pinyin, :subindex

  validates :base,             presence: true, length: { maximum: 3 }
  validates :offset,           presence: true, length: { maximum: 3 }
  validates :pinyin,           presence: true, length: { maximum: 8 }
  validates :name_word,        presence: true, length: { maximum: 30 }
  validates :name_word_abrev,  presence: true, length: { maximum: 10 }
  validates :part_of_speech,   presence: true, length: { maximum: 12 }

end
