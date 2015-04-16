class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.default?
      can :read, User, id: user.id
      can :read, Order
      can :create, Order
    end
    if user.userable_type == "Seller"
      can :edit, Garment, seller_id: user.userable_id
      can :update, Garment, seller_id: user.userable_id
    end
    if user.admin?
      can :manage, :all
    end
  end
end
