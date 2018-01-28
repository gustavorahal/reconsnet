class AddPersonToUsers < ActiveRecord::Migration[4.2]
  def change
    add_reference :users, :person, index: true, null: true
  end
end
