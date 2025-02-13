class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.string :sender_name, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
