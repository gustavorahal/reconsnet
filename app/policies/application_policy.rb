class ApplicationPolicy
  attr_reader :user, :record

  self::Scope = Struct.new(:user, :scope) do
    def resolve
      if user.nil? # anonymous
        scope.all
      elsif user.admin?
        scope.all
      else
        scope.all
        #scope.where(:published => true)
      end
    end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    true
  end

  def new?
    true
  end

  def update?
    true
  end

  def edit?
    #return false if @user.nil?
    #true if @user.admin?
    true
  end

  def destroy?
    true
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

