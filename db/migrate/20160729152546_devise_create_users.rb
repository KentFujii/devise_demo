class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :hashed_password
      t.boolean :profile_delivered, null: false, default: false

      t.timestamps null: false
    end
  end
end
