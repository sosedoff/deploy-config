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
      @data    = Hashr.new(attrs)
      @targets = Hashr.new
    end

    # Validate manifest
    def validate
      raise DeployManifest::Error, "Manifest is empty" if data.empty?
      raise DeployManifest::Error, "Manifest does not have app definition" if !data.app?

      if data.targets?
        data.targets.each_pair do |k,v|
          raise DeployManifest::Error, "Target #{k} is invalid" if !v.kind_of?(Hash)
          raise DeployManifest::Error, "Target #{k} is missing attributes" if !v.keys.include_all?(TARGET_FIELDS)

          v.delete_if { |k,v| !TARGET_FIELDS.include?(k) }
          @targets[k] = DeployManifest::Target.new(k.to_s, v)
        end
      end
    end
  end
end