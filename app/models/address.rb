# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
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

  def country_name
    if country_code
      Carmen::Country.coded(country_code).name
    end
  end

  def state_name
    if country_code and state_code
      c = Carmen::Country.coded(country_code)
      c.subregions.coded(state_code).name
    end
  end

end
