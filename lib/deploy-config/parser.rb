module DeployConfig
  module Parser
    PRIMARY_FIELDS = [:app, :targets, :hooks, :setup]
    TARGET_FIELDS  = [:host, :user, :password, :deploy_to]
    HOOKS_FIELDS   = [
      :before_deploy,
      :before_code_update,
      :after_code_update,
      :after_deploy
    ]

    def parse_application(data)
      app = Hashr.new(data)

      raise DeployConfig::Error, "App name required"   if !app.name?
      raise DeployConfig::Error, "App type required"   if !app.deploy?
      raise DeployConfig::Error, "App source required" if !app.git?

      if !valid_app_name?(app.name)
        raise DeployConfig::Error, "App name is not valid"
      end

      if !valid_app_type?(app.deploy)
        raise DeployConfig::Error, "App type is invalid"
      end

      if !valid_git_url?(app.git)
        raise DeployConfig::Error, "App source is invalid"
      end

      @app      = app.name
      @app_type = app.deploy
      @git      = app.git
    end

    def parse_targets(data)
      if data.kind_of?(Hash)
        data.each_pair do |k,v|
          raise DeployConfig::Error, "Target #{k} is invalid" if !v.kind_of?(Hash)
          raise DeployConfig::Error, "Target #{k} is missing attributes" if !v.keys.include_all?(TARGET_FIELDS)

          v.delete_if { |k,v| !TARGET_FIELDS.include?(k) }
          @targets[k] = DeployConfig::Target.new(k.to_s, v)
        end
      else
        raise DeployConfig::Error, "Targets section is invalid"
      end
    end

    def parse_hooks(data)
      unless data.kind_of?(Hash)
        raise DeployConfig::Error, "Hooks section is invalid"
      end
      data.delete_if { |k,v| HOOKS_FIELDS.include?(k) }
      @hooks = data
    end
  end
end