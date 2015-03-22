# == Schema Information
#
# Table name: assets
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :string(255)
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  attachable_id     :integer
#  attachable_type   :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class Asset < ActiveRecord::Base
  belongs_to :assetable, :polymorphic => true

  has_attached_file :file
  validates_attachment_content_type :file, content_type: %w(application/vnd.ms-excel
                                                           application/vnd.ms-powerpoint
                                                           application/msword
                                                           application/vnd.openxmlformats-officedocument.wordprocessingml.document
                                                           application/pdf)
  #do_not_validate_attachment_file_type :file
  validates :name, presence: true


  def to_s
    file_file_name
  end

end
