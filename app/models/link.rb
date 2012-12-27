class Link < ActiveRecord::Base
	# Should make only formula_id accessible?
  attr_accessible :formula_id, :formula_ord, :graph_id, :pinname_id, :pinname_ord, :weight

  belongs_to :pinname, class_name: "Pinname"
  belongs_to :formula, class_name: "Formula"

  validates :graph_id,   presence: true
  validates :pinname_id, presence: true
  validates :formula_id, presence: true

end

