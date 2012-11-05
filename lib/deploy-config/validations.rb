module DeployConfig
  module Validations
    extend self

    REGEX_APP      = /\A[a-z\d\-\_]{1,64}\z/i
    REGEX_GIT_SSH  = /\A[a-z\d\-]{1,}@[a-z\d\-\.]{1,}:[a-z\d\-\_\.\/]{1,}.git\z/i
    REGEX_GIT_HTTP = /\A(http(s?)|git):\/\/[a-z\d\-\.]{1,}\/[a-z\d\-\_\.\/]{1,}.git\z/i

    # Validate application name
    # @param str [String] application name
    # @return [Boolean] validation result
    def valid_app_name?(str)
      str =~ REGEX_APP ? true : false
    end

    # Check if git url is correct
    # @param str [String] git repository url
    # @return [Boolean] validation result
    def valid_git_url?(url)
      url.match(REGEX_GIT_SSH) || url.match(REGEX_GIT_HTTP)
    end

    # Validate application type
    # @param str [String] application type
    # @return [Boolean] validation result
    def valid_app_type?(str)
      %w(static rack rails3 sinatra wordpress django cakephp).include?(str)
    end
  end
end