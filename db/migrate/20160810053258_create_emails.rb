class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.references :user
      t.string :address
      t.string :provider
      t.string :uid
    end
  end
end
