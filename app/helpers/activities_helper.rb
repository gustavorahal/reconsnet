module ActivitiesHelper

  def activity_link_display(activity)
    link = link_to(activity.name, activity_path(activity))
    if activity.parent.present?
      parent = activity.parent
      link += " parte do(a) #{parent.name}".html_safe
    end

    link
  end


  def internal_only_display(activity)
    '<span class="glyphicon glyphicon-ok"></span>'.html_safe if activity.internal_only?
  end

end