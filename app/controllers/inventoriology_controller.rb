class InventoriologyController < ApplicationController

  after_action :verify_authorized

  def index
    authorize :inventoriology

    @start = Time.utc(2014, 1, 1, 00, 00, 01)
    @finish = Time.utc(2014, 12, 31, 23, 59, 59)
    @events = Event.where('start >= ?', @start).where('finish <= ?', @finish)
    #@part_count = Participation.joins(:event).where('events.start >= ?', @start).where('events.finish <= ?', @finish).where('participations.status = \'Inscrito\'').count
    @people = Person.joins(participations: :event).where('events.start >= ?', @start).where('events.finish <= ?', @finish).uniq
    @male_count = @people.where(gender: 'Masculino').count
    @female_count = @people.where(gender: 'Feminino').count
    @gen_undef_count = @people.where(gender: ['', nil]).count
    @occupations = @people.where.not(occupation: [nil, '']).group(:occupation).count
    #@cities = Address.joins(:person).where(person: @people).where.not(city: [nil, '']).group(:city).count
  end

end