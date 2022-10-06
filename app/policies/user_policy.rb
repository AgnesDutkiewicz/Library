class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def index?
    current_user
  end

  def show?
    current_user.id == user.id || current_user.admin?
  end

  def create?
    true
  end

  alias edit? show?

  alias update? show?

  alias destroy? show?

  private

  attr_reader :current_user, :user
end
