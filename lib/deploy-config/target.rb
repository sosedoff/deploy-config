module DeployConfig
  class Target
    attr_reader :name
    attr_reader :host, :port
    attr_reader :user, :password
    attr_reader :deploy_to

    # Initialize a new Target instance
    # @param options [Hash]
    def initialize(name, options={})
      @name      = name
      @host      = options[:host]
      @port      = options[:port] || 22
      @user      = options[:user]
      @password  = options[:password]
      @deploy_to = options[:deploy_to]
    end
  end
end