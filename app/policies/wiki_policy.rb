class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index?
    user.present?
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    user.account_active?
  end

  def new?
    create?
  end

  def update?
    user.account_active?
  end

  def edit?
    update?
  end

  def destroy?
    user.account_active?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
