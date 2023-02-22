class ListPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope means List
      # user means current user
      # scope.all -> List.all
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
    # record is the instance
    record.user == user
  end
end

# in the view
# I can use
# if policy(@list).edit?
#   show some edit button
# end