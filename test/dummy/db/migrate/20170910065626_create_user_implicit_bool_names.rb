class CreateUserImplicitBoolNames < ActiveRecord::Migration[5.1]
  def change
    create_table :user_implicit_bool_names do |t|
      t.datetime :verified_at

      t.timestamps
    end
  end
end
