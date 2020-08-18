class UserPolicy < ApplicationPolicy
  def index?
    user.owner
  end

  def show?
    user.owner && record.sitter
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
