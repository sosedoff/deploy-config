module DeployManifest
  class Manifest
    PRIMARY_FIELDS = %w(app targets hooks setup)
    TARGET_FIELDS  = %w(host port user password deploy_to)
    HOOKS_FIELDS   = [
      'before_deploy',
      'before_code_update',
      'after_code_update',
      'after_deploy'
    ]

    include DeployManifest::Parser
    include DeployManifest::Validations
    include DeployManifest::Helpers

    attr_reader :app
    attr_reader :app_type
    attr_reader :git
    attr_reader :deploy_mode

    attr_reader :data

    # Initialize a new manifest instance
    # @param attrs [Hash] attributes hash
    def initialize(attrs={})
      @data = Hashr.new(attrs)
    end

    # Validate manifest
    def validate
      if data.empty?
        raise DeployManifest::Error, "Manifest is empty"
      end

      if !data.app?
        raise DeployManifest::Error, "Manifest does not have app definition"
      end
    end
  end
end