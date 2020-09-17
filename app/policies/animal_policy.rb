class AnimalPolicy < ApplicationPolicy
  def index?
    user.owner
  end

  def show?
    user.owner || user.sitter
  end

  def create?
    user.owner
  end

  def edit?
    is_owner?
  end

  def update?
    is_owner?
  end

  def destroy?
    is_owner?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
