module DeployManifest
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
      raise DeployManifest::Error, "App is not defined"   if data.nil?
      raise DeployManifest::Error, "App name required"    if data.name.nil?
      raise DeployManifest::Error, "App type required"    if data.type.nil?
      raise DeployManifest::Error, "App source required"  if data.git.nil?

      if !valid_app_name?(data.name)
        raise DeployManifest::Error, "App name is not valid"
      end

      if !valid_app_type?(data.type)
        raise DeployManifest::Error, "App type is invalid"
      end

      if !valid_git_url?(data.git)
        raise DeployManifest::Error, "App source is invalid"
      end

      @app      = data.name
      @app_type = data.app_type
      @git      = data.git
    end

    def parse_targets(data)
      if data.kind_of?(Hash)
        data.each_pair do |k,v|
          raise DeployManifest::Error, "Target #{k} is invalid" if !v.kind_of?(Hash)
          raise DeployManifest::Error, "Target #{k} is missing attributes" if !v.keys.include_all?(TARGET_FIELDS)

          v.delete_if { |k,v| !TARGET_FIELDS.include?(k) }
          @targets[k] = DeployManifest::Target.new(k.to_s, v)
        end
      else
        raise DeployManifest::Error, "Targets section is invalid"
      end
    end

    def parse_hooks(data)
      unless data.kind_of?(Hash)
        raise DeployManifest::Error, "Hooks section is invalid"
      end
      data.delete_if { |k,v| HOOKS_FIELDS.include?(k) }
      @hooks = data
    end
  end
end