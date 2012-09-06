module DeployManifest
  class Manifest
    PRIMARY_FIELDS = [:app, :targets, :hooks, :setup]
    TARGET_FIELDS  = [:host, :user, :password, :deploy_to]
    HOOKS_FIELDS   = [
      :before_deploy,
      :before_code_update,
      :after_code_update,
      :after_deploy
    ]

    include DeployManifest::Parser
    include DeployManifest::Validations
    include DeployManifest::Helpers

    attr_reader :app
    attr_reader :app_type
    attr_reader :git
    attr_reader :deploy_mode
    attr_reader :targets

    attr_reader :data

    # Initialize a new manifest instance
    # @param attrs [Hash] attributes hash
    def initialize(attrs={})
      @data = Hashr.new(attrs)
      @targets = {}
    end

    # Validate manifest
    def validate
      if data.empty?
        raise DeployManifest::Error, "Manifest is empty"
      end

      if !data.app?
        raise DeployManifest::Error, "Manifest does not have app definition"
      end

      if data.targets?
        data.targets.each_pair do |k,v|
          if !v.kind_of?(Hash)
            raise DeployManifest::Error, "Target #{k} is invalid"
          end
          
          if !v.keys.include_all?(TARGET_FIELDS)
            raise DeployManifest::Error, "Target #{k} is missing attributes"
          end

          # Keep only available keys
          v.delete_if { |k,v| !TARGET_FIELDS.include?(k) }

          @targets[k] = v
        end
      end
    end
  end
end