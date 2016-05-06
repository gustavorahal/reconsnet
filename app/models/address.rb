# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  label            :string(255)
#  line1            :string(255)
#  city             :string(255)
#  state            :string(255)
#  zip              :string(255)
#  country          :string(255)
#  addressable_id   :integer
#  addressable_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class Address < ActiveRecord::Base
  has_paper_trail meta: { person_id: lambda { |addr| addr.addressable_id if addr.addressable_type == 'Person' } }

  belongs_to :addressable, :polymorphic => true


  def to_s
    line1
  end
end
