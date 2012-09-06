module DeployManifest
  module Validations
    extend self

    REGEX_APP      = /\A[a-z\d\-\_]{1,64}\z/i
    REGEX_GIT_SSH  = /\A[a-z\d\-]@[a-z\d\-\.]:[a-z\d\-\_\.].git\z/i
    REGEX_GIT_HTTP = nil # TODO

    # Validate application name
    # @param str [String] application name
    # @return [Boolean] validation result
    def validate_app_name(str)
      str =~ REGEX_APP ? true : false
    end

    # Check if git url is correct
    # @param str [String] git repository url
    # @return [Boolean] validation result
    def validate_git_url(str)
      str =~ REGEX_GIT_SSH ? true : false
    end

    # Validate application type
    # @param str [String] application type
    # @return [Boolean] validation result
    def validate_app_type(str)
      %w(rack rails3 sinatra wordpress cakephp).include?(str)
    end
  end
end