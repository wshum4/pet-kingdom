class ReviewPolicy < ApplicationPolicy
  def new?
    user.sitter
  end

  def create?
    user.sitter
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
