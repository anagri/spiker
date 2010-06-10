privileges do
  privilege :create do
    includes :new, :create, :show
  end

  privilege :update do
    includes :edit, :update, :show
  end

  privilege :manage do
    includes :create, :update, :index
  end

  privilege :su do
    includes :all
  end
end

authorization do
  role :guest do
    has_permission_on :users, :to => :create
  end

  role :user do
    has_permission_on :users, :to => :update do
      if_attribute :id => is {user.id}
    end
  end
end