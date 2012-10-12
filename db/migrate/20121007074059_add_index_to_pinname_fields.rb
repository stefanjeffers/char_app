class AddIndexToPinnameFields < ActiveRecord::Migration
  def change

    add_index :pinnames, :base
    add_index :pinnames, :offset
    add_index :pinnames, :pinyin
    add_index :pinnames, :name_word
    add_index :pinnames, :name_word_abbrev
    add_index :pinnames, :part_of_speech

  end
end
