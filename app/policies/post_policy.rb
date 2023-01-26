class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    record.user_id == user.id
  end

  def edit?
    update?
  end

  def destroy?
    record.user_id == user.id
  end
end
