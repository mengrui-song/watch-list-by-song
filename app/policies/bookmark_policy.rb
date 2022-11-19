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
    record.user == user
  end

  def new?
    true
  end

  def create?
    true
  end

  def destroy
    record.user == user
  end
end
