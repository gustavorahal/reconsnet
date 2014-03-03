module ApplicationHelper

  def process_flash_msgs
    case flash.keys
      when :notice then return ['success', flash[:notice]]
      when :alert then return ['danger', flash[:alert]]
    end

  end

end
