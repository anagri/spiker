def params_hash(params)
  HashWithIndifferentAccess.new(params)
end

def unauthorized_msg_key(action)
  "#{controller.class.name.decontrolled}.#{action}.unauthorized"
end


def all_actions(controller)
  eval("#{controller}.action_methods")
end