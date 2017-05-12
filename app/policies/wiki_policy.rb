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
    scope.where(:id => record.id).exists? && update?
  end

  def create?
    if wiki.private
      !user.standard? && user.account_active?
    else
      user.account_active?
    end
  end

  def new?
    create?
  end

  def update?
    if wiki.private
      user.account_active? && wiki.user == user || wiki.collaborators.include?(user)
    else
      user.account_active?
    end
  end

  def edit?
    update?
  end

  def destroy?
    if wiki.private
      user.admin? || user.account_active? && wiki.user == user
    else
      user.account_active?
    end
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
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.collaborators.include?(user) || wiki.user == user
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
