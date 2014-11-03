module VersionsHelper

  def self.event_name_i18n(name)
    case name
      when 'update' then return 'atualizou'
      when 'create' then return 'criou'
      when 'destroy' then return 'excluiu'
    end
  end

  def self.item_type_i18n(item)
  end

end