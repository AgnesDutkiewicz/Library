class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user
  end

  def show?
    user
  end

  def create?
    true
  end

  def update?
    user.id == record.id
  end

  def destroy?
    user.id == record.id
  end

  private

  attr_reader :user, :record
end
