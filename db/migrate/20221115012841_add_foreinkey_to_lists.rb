class AddForeinkeyToLists < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :lists, foreign_key: true
  end
end
