# Source: http://stackoverflow.com/questions/4435826/rails-paperclip-how-to-delete-attachment

# This needs to be included after all has_attached_file statements in a class
module DeletableAttachment
  extend ActiveSupport::Concern

  included do
    attachment_definitions.keys.each do |name|

      attr_accessor :"delete_#{name}"

      before_validation { send(name).clear if send("delete_#{name}") == '1' }

      define_method :"delete_#{name}=" do |value|
        instance_variable_set :"@delete_#{name}", value
        send("#{name}_file_name_will_change!") if value == '1'
      end

    end
  end

end