class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :graph_id
      t.integer :pinname_id
      t.string :pinname_ord
      t.integer :formula_id
      t.string :formula_ord
      t.string :weight

      t.timestamps
    end

    add_index :links, :graph_id
    add_index :links, :pinname_id
    add_index :links, :formula_id
    # add_index :links, [:pinname_id, :formula_id], unique: true
    add_index :links, [:pinname_id, :formula_id]

  end
end
