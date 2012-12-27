class AddGraphIdToFormulas < ActiveRecord::Migration
  def change
    add_column :formulas, :graph_id, :string
    add_index  :formulas, :graph_id
  end
end
