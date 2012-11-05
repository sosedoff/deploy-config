module DeployConfig
  class Manifest
    include DeployConfig::Parser
    include DeployConfig::Validations
    include DeployConfig::Helpers

    attr_reader :app
    attr_reader :app_type
    attr_reader :git
    attr_reader :targets
    attr_reader :config
    attr_reader :original_data

    # Initialize a new manifest instance
    # @param attrs [Hash] attributes hash
    def initialize(attrs={})
      @original_data = Hashr.new(attrs)
      @targets       = Hashr.new
      @hooks         = Hashr.new
      @config        = Hashr.new
    end

    # Parse manifest data
    def parse!
      parse_application(original_data.app)
      parse_targets(original_data.targets)

      if original_data.hooks
        parse_hooks(original_data.hooks)
      end
    end
  end
end