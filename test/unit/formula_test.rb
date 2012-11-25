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

require 'test_helper'

class FormulaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
