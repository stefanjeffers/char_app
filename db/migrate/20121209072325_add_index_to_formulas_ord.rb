class AddIndexToFormulasOrd < ActiveRecord::Migration
  def change
    add_index :formulas, :ord
  end
end
