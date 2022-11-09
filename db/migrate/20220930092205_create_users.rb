class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :mail, unique: true
      t.string :password_digest
      t.string :remember_digest

      t.timestamps
    end
  end
end
