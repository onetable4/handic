class CreateDicdata < ActiveRecord::Migration
  def change
    create_table :dicdata do |t|

      t.integer :dicnum
      t.string :title
      t.string :hanja
      
      t.timestamps null: false
    end
  end
end
