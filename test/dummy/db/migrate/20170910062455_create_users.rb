class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.datetime :verified_at

      t.timestamps
    end
  end
end
