class RequestPolicy < ApplicationPolicy
  def index?
    user.owner || user.sitter
  end

  def show?
    is_owner? || is_sitter?
  end

  def create?
    user.owner
  end

  def edit?
    is_owner?
  end

  def update?
    is_owner? || is_sitter?
  end

  def destroy?
    is_owner?
  end

  def submit_confirm?
    is_owner?
  end

  def update_confirm?
    is_owner? || is_sitter?
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

  private

  def is_owner?
    user.owner && record.owner == user
  end

  def is_sitter?
    user.sitter && record.sitter == user
  end
end
