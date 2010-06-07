privileges do
  privilege :create do
    includes :new, :create
  end

  privilege :modify do
    includes :edit, :update
  end
end

authorization do
  role :guest do
    has_permission_on :users, :to => :create
  end

  role :user do
    has_permission_on :users, :to => :modify do
      if_attribute :id => is {user.id}
    end
  end
end