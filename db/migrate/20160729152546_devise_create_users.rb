class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :name
      t.string :uid
      t.string :provider

      t.timestamps null: false
    end
  end
end
