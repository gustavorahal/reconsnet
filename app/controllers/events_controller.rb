class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy, :participants,
                                   :attendance, :emails, :archive, :unarchive, :roles,
                                   :versions]
  after_action :verify_authorized

  def index
    if current_user and current_user.is_volunteer?
      @events_by_year = Event.order('start').group_by { |m| m.start.beginning_of_year.year }
    else
      @events_by_year = Event.order('start').all_exclude_internal.group_by { |m| m.start.beginning_of_year.year }
    end

    authorize Event.new
  end

  def show
    @assets_by_type = ActiveSupport::OrderedHash[Asset.asset_types.map { |f| [f[0], []]}]
    @event.assets.group('asset_type, id').each do |asset|
      @assets_by_type[asset.asset_type].push asset
    end
  end

  def new
    @event = Event.new
    authorize @event
    @activity = nil
    @activity = Activity.find params[:activity_id] if params[:activity_id]
  end

  def edit
  end

  def create
    @event = Event.new(secure_params)
    if @event.activity.blank?
      # neste cenário o activity_id foi passado por url e não veio pelo form
      @event.activity = Activity.find params[:activity_id]
    end
    if @event.name.blank?
      @event.name = @event.activity.name
    end
    authorize @event

    if @event.save
      redirect_to event_path(@event)
    else
      render 'new'
    end
  end

  def update
    if @event.update(secure_params)
      redirect_to @event, notice: "Evento '#{@event.name}' atualizado com sucesso!"
    else
      render 'edit'
    end
  end

  def destroy
    if @event.safely_destroyable?
      redirect_to events_path, notice: "Evento '#{@event.name}' deletado com sucesso!" if @event.destroy
    else
      redirect_to events_path, alert: "Evento '#{@event.name}' tem restrições para ser deletado!"
    end
  end

  def archive
    if @event.archivable?
      @event.archived = true
      if @event.save
        redirect_to @event, notice: 'Evento arquivado com sucesso!'
      else
        redirect_to @event, alert: 'Erro desconhecido ao tentar arquivar este evento'
      end
    else
      redirect_to @event, alert: 'Existem pendências que não permitem o arquivamento deste evento. Favor verificar'
    end
  end

  def unarchive
    redirect_to @event, alert: 'Evento não esta arquivado para ser desarquivado!' unless @event.archived

    @event.archived = false
    if @event.save
      redirect_to @event, notice: 'Evento desarquivado com sucesso!'
    else
      redirect_to @event, alert: 'Erro desconhecido ao tentar desarquivar este evento'
    end

  end

  def participants
    respond_to do |format|
      format.html
      format.pdf do
        pdf = EventParticipantsPdf.new(@event, current_user)
        send_data pdf.render, filename: "event_id_#{@event.id}_participants.pdf", type: 'application/pdf'
      end
    end
  end

  def attendance
    respond_to do |format|
      format.html
      format.pdf do
        pdf = EventAttendancePdf.new(@event, current_user)
        send_data pdf.render, filename: "event_id_#{@event.id}_attendance.pdf", type: 'application/pdf'
      end
    end
  end

  def emails
  end

  def calendar
    if current_user and current_user.is_volunteer?
      @events = Event.sorted
    else
      @events = Event.sorted.all_exclude_internal
    end

    authorize @events

    @events_by_date = {}
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @events.where('start >= ? AND finish <= ?', (@date - 1.month).beginning_of_month,
                                                (@date + 1.month).end_of_month).each do |event|
      (event.start.to_date..event.finish.to_date).to_a.each do |date|
        if @events_by_date[date].present?
          @events_by_date[date].append event
        else
          @events_by_date[date] = [event]
        end
      end
    end
  end

  def roles
  end

  def versions
    sql = "(item_type='Event' AND item_id=#{@event.id})"
    sql += " OR (item_type='Participation' AND event_id=#{@event.id})"

    @versions = PaperTrail::Version.where(sql).order(created_at: :desc).page(params[:page]).per(10)
    authorize @event
  end


  private

    def set_event
      @event = Event.find params[:id]
      authorize @event
    end

    def secure_params
      params.require(:event).permit(:activity_id, :name, :description, :event_type, :start, :finish, :original_updated_at)
    end

end
