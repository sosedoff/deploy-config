module DeployManifest
  module Helpers
    # Generate a release string
    # @return [String]
    def release_string
      Time.now.utc.strftime("%d%m%Y%H%M%S")
    end
  end
end