module DeployManifest
  class Manifest
    include DeployManifest::Parser
    include DeployManifest::Validations
    include DeployManifest::Helpers

    attr_reader :app
    attr_reader :app_type
    attr_reader :git
    attr_reader :deploy_mode
    attr_reader :targets

    # Initialize a new manifest instance
    # @param attrs [Hash] attributes hash
    def initialize(attrs={})
      data     = Hashr.new(attrs)
      @targets = Hashr.new
      @hooks   = Hashr.new

      parse_application(data.app)
      parse_targets(data.targets)
      parse_hooks(data.hooks)
    end

    # Validate manifest
    def validate
      raise DeployManifest::Error, "Manifest is empty" if data.empty?
      raise DeployManifest::Error, "Manifest does not have app definition" if !data.app?
    end
  end
end