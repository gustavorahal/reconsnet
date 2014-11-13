module VersionsHelper

  def self.event_name_i18n(name)
    case name
      when 'update' then return 'mudou'
      when 'create' then return 'criou'
      when 'destroy' then return 'excluiu'
    end
  end

end