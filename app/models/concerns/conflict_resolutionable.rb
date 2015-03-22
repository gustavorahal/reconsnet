module ConflictResolutionable

  extend ActiveSupport::Concern

  def original_updated_at
    @original_updated_at || updated_at.to_f
  end
  attr_writer :original_updated_at

  def handle_conflict
    if @conflict || updated_at.to_f > original_updated_at.to_f
      @conflict = true
      @original_updated_at = nil
      errors.add :base, 'Este registro mudou enquanto você editava-o. Veja as mudanças informadas e leve-as em consideração antes de submeter novamente.'
      changes.each do |attribute, values|
        errors.add attribute, "era #{values.first}"
      end
    end
  end

end