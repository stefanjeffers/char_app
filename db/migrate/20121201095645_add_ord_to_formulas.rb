class AddOrdToFormulas < ActiveRecord::Migration
  def change
        add_column :formulas, :ord, :string
  end
end
