# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  label            :string(255)
#  line1            :string(255)
#  city             :string(255)
#  state_code       :string(255)
#  zip              :string(255)
#  country_code     :string(255)
#  addressable_id   :integer
#  addressable_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true
end
