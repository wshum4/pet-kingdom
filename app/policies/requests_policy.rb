class RequestsPolicy < ApplicationPolicy
  def create?
    user.owner
  end

  def update?
    user.sitter && record.sitter == user
  end

  def destroy?
    user.owner && record.owner == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
