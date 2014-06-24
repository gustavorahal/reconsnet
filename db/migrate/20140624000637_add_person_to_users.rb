class AddPersonToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :person, index: true, null: true
  end
end
