class WikiPolicy < ApplicationPolicy
  include CollaboratorsHelper


  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index?
    @user.present?
  end

  def show?
    edit?
  end

  def create?
    if @wiki.private
      !@user.standard? && @user.account_active?
    else
      @user.account_active?
    end
  end

  def new?
    create?
  end

  def update?
    if @wiki.private
      @collaborators = @wiki.collaborators
      @user.account_active? && @wiki.user == @user || checked(@user)
    else
      @user.account_active?
    end
  end

  def edit?
    update?
  end

  def destroy?
    if wiki.private
      @user.admin? || @user.account_active? && @wiki.user == @user
    else
      @user.account_active?
    end
  end
end
