class RequestPolicy < ApplicationPolicy
  def index?
    user.owner || user.sitter
  end

  def show?
    record.owner == user || record.sitter == user
  end

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
      if user.owner
        scope.where(owner: user)
      elsif user.sitter
        scope.where(sitter: user)
      end
    end
  end
end
