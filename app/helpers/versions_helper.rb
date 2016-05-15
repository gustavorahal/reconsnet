module VersionsHelper

  def self.event_name_i18n(name)
    case name
      when 'update' then return 'editou'
      when 'create' then return 'adicionou'
      when 'destroy' then return 'excluiu'
    end
  end

  def self.changeset(version, resource)

    # Esta listagem inclui os ignored para todos os objetos que estão cadastrados no
    # paper_trail.

    # Default para todos
    ignore_attrs = %w(updated_at created_at id)
    # Para PhoneNumber e Address
    ignore_attrs += %w(phonable_id phonable_type addressable_id addressable_type)
    # Para Participation. O nome do evento e da pessoa já aparecem no título então não é necessário aparecer no changeset
    ignore_attrs += %w(event_id person_id)

    changeset = {}
    if version.event == 'destroy'
      resource.serializable_hash.dup.except(*ignore_attrs).each do |k,v|
        changeset[k] = [v, '']
      end
    else
      changeset = version.changeset.dup.except(*ignore_attrs)
    end

    changeset
  end

  def self.attribute_display(resource_name, attrib_name, attrib_value, stripped = false)

    return '<em class=text-muted>&ltvazio&gt</em>'.html_safe if attrib_value.blank?

    html = ''

    if resource_name == 'Participation' and attrib_name == 'person_id'
      html += Person.find(attrib_value).name
    elsif resource_name == 'Participation' and attrib_name == 'event_id'
      html += Event.find(attrib_value).name
    elsif resource_name == 'Participation' and attrib_name == 'attendance'
      html += I18n.t("participation.attendance.#{attrib_value}").downcase
    elsif resource_name == 'Participation' and attrib_name == 'p_type'
      html += I18n.t("participation.types.#{attrib_value}").downcase
    elsif resource_name == 'Participation' and attrib_name == 'status'
      html += I18n.t("participation.status.#{attrib_value}").downcase
    else
      html += attrib_value.to_s
    end

    return stripped ? "<s>#{html}</s>".html_safe : html.html_safe

  end

end