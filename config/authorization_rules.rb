privileges do
  privilege :build do
    includes :new, :create, :show
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
    has_permission_on :users, :to => :build
    has_permission_on :sessions, :to => :build
  end

  role :staff do
    has_permission_on :users, :to => :modify do
      if_attribute :id => is {user.id}
    end
    has_permission_on :sessions, :to => :destroy
  end
end