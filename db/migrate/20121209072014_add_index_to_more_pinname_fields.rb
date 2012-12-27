class AddIndexToMorePinnameFields < ActiveRecord::Migration
  def change
    add_index :pinnames, :graph_id
    add_index :pinnames, :ord
    add_index :pinnames, :subindex
  end
end
