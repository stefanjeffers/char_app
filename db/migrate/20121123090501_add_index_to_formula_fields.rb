class AddIndexToFormulaFields < ActiveRecord::Migration
  def change

    add_index :formulas, :base
    add_index :formulas, :offset
    add_index :formulas, :subindex

    add_index :formulas, :iform
    add_index :formulas, :word_form
    add_index :formulas, :abbrev_form
    add_index :formulas, :alpha

  end
end
