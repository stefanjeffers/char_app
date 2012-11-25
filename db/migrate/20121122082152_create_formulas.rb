class CreateFormulas < ActiveRecord::Migration
  def change
    create_table :formulas do |t|
      t.string :base
      t.string :offset
      t.string :subindex
      t.string :iform
      t.string :word_form
      t.string :abbrev_form
      t.string :alpha

      t.timestamps
    end
  end
end
