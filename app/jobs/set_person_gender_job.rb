class SetPersonGenderJob < ActiveJob::Base
  queue_as :default

  def perform(person)
    return if person.first_name.blank?

    gender = Gendered::Name.new(person.first_name).guess!
    case gender
      when :male then
        person.gender = 'Masculino'
        person.save!
      when :female then
        person.gender = 'Feminino'
        person.save!
    end
  end
end
