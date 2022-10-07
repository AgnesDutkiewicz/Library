class AuthorPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    true
  end

  alias show? index?

  def create?
    user_admin?
  end

  alias update? create?
end
