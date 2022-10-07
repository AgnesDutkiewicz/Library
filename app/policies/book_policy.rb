class BookPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if !user.present? || !user.admin?
        scope.where.not(category: '18+')
      else
        scope.all
      end
    end
  end

  def index?
    true
  end

  alias show? index?

  def create?
    user_admin?
  end

  alias update? create?
  alias destroy? create?
end
