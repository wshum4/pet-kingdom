class ReviewPolicy < ApplicationPolicy
  def new?
    user.owner
  end

  def create?
    user.owner
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
