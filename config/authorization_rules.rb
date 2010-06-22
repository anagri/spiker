privileges do
  privilege :build do
    includes :new, :create
  end

  privilege :modify do
    includes :edit, :update, :show
  end

  privilege :manage do
    includes :build, :modify, :index
  end

  privilege :su do
    includes :all
  end
end

authorization do
  role :guest do
    has_permission_on :home, :to => :index
    has_permission_on :users, :to => :build
    has_permission_on :sessions, :to => :build
    has_permission_on :password_resets, :to => :manage
  end

  role :staff do
    has_permission_on :users, :to => :modify do
      if_attribute :id => is {user.id}
    end
    has_permission_on :sessions, :to => :destroy
  end

  role :admin do
    has_permission_on :sessions, :to => :destroy
    has_permission_on :offices, :to => :manage
    has_permission_on :office_types, :to => :manage
  end
end