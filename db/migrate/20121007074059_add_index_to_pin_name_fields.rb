class AddIndexToPinNameFields < ActiveRecord::Migration
  def change

    add_index :pin_names, :base
    add_index :pin_names, :offset
    add_index :pin_names, :pinyin
    add_index :pin_names, :name_word
    add_index :pin_names, :name_word_abrev
    add_index :pin_names, :part_of_speech

  end
end
