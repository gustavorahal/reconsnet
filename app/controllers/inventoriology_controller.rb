class InventoriologyController < ApplicationController

  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    authorize :inventoriology
  end

  def create
    authorize :inventoriology

    @start = Date.new params["start(1i)"].to_i, params["start(2i)"].to_i, params["start(3i)"].to_i
    @finish = Date.new params["end(1i)"].to_i, params["end(2i)"].to_i, params["end(3i)"].to_i

    @events = Event.order('start').where('start >= ?', @start).where('finish <= ?', @finish)
    #@part_count = Participation.joins(:event).where('events.start >= ?', @start).where('events.finish <= ?', @finish).where('participations.status = \'Inscrito\'').count
    @people = Person.joins(participations: :event).where('events.start >= ?', @start).where('events.finish <= ?', @finish).uniq
    @male_count = @people.where(gender: 'Masculino').count
    @female_count = @people.where(gender: 'Feminino').count
    @gen_undef_count = @people.where(gender: ['', nil]).count
    @occupations = @people.where.not(occupation: [nil, '']).group(:occupation).order('people.occupation').count
    #@cities = Address.joins(:person).where(person: @people).where.not(city: [nil, '']).group(:city).count
  end


end