# == Schema Information
#
# Table name: resource_assets
#
#  id                :integer          not null, primary key
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  assetable_id      :integer
#  assetable_type    :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  asset_type        :integer
#

class ResourceAsset < ApplicationRecord

  enum asset_type: { attendance_list: 0,
                     instructor_material: 1,
                     participant_material: 2,
                     leaflet: 3,
                     other: 99 }

  belongs_to :assetable, :polymorphic => true

  has_one_attached :file

  before_destroy do |asset|
    # For some reason ActiveStorage does not delete the Blob file, only the
    # entry in the attachment table
    asset.file.purge
  end

  validates_presence_of :asset_type

  ## TODO: Once activestorage supports validation, use the legacy paperclip
  ## validation below as a reference
  #
  # validates_attachment_content_type :file, content_type: %w(
  #                                                          application/vnd.ms-excel
  #                                                          application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
  #                                                          application/vnd.ms-powerpoint
  #                                                          application/vnd.openxmlformats-officedocument.presentationml.presentation
  #                                                          application/msword
  #                                                          application/vnd.openxmlformats-officedocument.wordprocessingml.document
  #                                                          application/pdf
  #                                                          image/jpeg
  #                                                          image/png)

  #validates_attachment_size :file, :less_than => 15.megabytes

end
