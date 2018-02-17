# /activities/avatars/ e Activity - OK!!
# /people/avatars/ e Person - OK!!
# /resource_assets/files/ e ResourceAsset - OK!!


Dir.glob("#{Rails.root}/public/system/resource_assets/files/*/*/*/original/*").each do |path|
  attachment = File.open path

  # skip directories
  next if File.directory? attachment

  full_path = File.expand_path attachment
  # find id to update
  id = full_path.match(/(\d+)\/original\/.+$/)[1]
  puts "Re-saving ##{id}..."
  next unless ResourceAsset.exists?(id)
  your_model = ResourceAsset.find(id)

  # Paperclip will re-save the attachment using the new settings
  your_model.file = attachment
  your_model.save
end


# Dir.glob("#{Rails.root}/public/system/activities/avatars/*/*/*/original/*").each do |path|
#   attachment = File.open path
#   next if File.directory? attachment
#   full_path = File.expand_path attachment
#   id = full_path.match(/(\d+)\/original\/.+$/)[1]
#   puts "Re-saving ##{id}..."
# end
