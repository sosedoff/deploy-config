module DeployManifest
  class Manifest
    include DeployManifest::Parser
    include DeployManifest::Validations
    include DeployManifest::Helpers

    attr_reader :app
    attr_reader :app_type
    attr_reader :git
    attr_reader :deploy_mode

    # Initialize a new manifest instance
    # @param data [Hash] data hash
    def initialize(hash={})
      data = Hashr.new(hash)
    end
  end
end