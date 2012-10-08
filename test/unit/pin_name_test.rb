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

require 'test_helper'

class PinNameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
