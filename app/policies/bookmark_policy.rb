class BookmarkPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope.all
      scope.where(user: user)
    end
  end

  def index?
    record.each do |r|
      r.user == user
    end
  end

  def show?
    user_is_owner?
  end

  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    user_is_owner?
  end

  private
  def user_is_owner?
    record.list.user == user
  end
end
