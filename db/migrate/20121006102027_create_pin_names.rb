class CreatePinNames < ActiveRecord::Migration
  def change
    create_table :pin_names do |t|
      t.string :base
      t.string :offset
      t.string :subindex
      t.string :ord
      t.string :pinyin
      t.string :name_word
      t.string :name_word_abrev
      t.string :part_of_speech
      t.string :graph_id

      t.timestamps
    end
  end
end
