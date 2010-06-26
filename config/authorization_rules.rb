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

  privilege :view do
    includes :index, :show
  end

  privilege :su do
    includes :all
  end
end

authorization do
  role :guest do
    has_permission_on :home, :to => :index
    has_permission_on :sessions, :to => :build
    has_permission_on :password_resets, :to => :manage
  end

  role :authenticated_user do
    has_permission_on :sessions, :to => [:create, :destroy]
    has_permission_on :dashboard, :to => :index
  end

  role :staff do
    includes :authenticated_user
    has_permission_on :users, :to => :modify do
      if_attribute :id => is {user.id}
    end
    has_permission_on [:offices, :office_types, :client_types], :to => :view
  end

  role :admin do
    includes :authenticated_user
    has_permission_on [:users, :offices, :office_types, :client_types], :to => :manage
  end
end