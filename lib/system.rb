class System
  class << self
    def current_user
      RequestStore.store[:current_user]
    end

    # sets stamps for created_by/updated_by attributes
    def current_user=(user)
      RequestStore.store[:current_user] = user
    end

    def current_process
      RequestStore.store[:current_process]
    end

    # sets stamp for changed_by attribute
    def current_process=(process_name)
      RequestStore.store[:current_process] = process_name
    end
  end
end
