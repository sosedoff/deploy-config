require 'rubygems'
require 'yaml'
require 'hashr'

require 'deploy-config/core_ext/array'
require 'deploy-config/core_ext/hash'
require 'deploy-config/version'
require 'deploy-config/errors'
require 'deploy-config/helpers'
require 'deploy-config/validations'
require 'deploy-config/parser'
require 'deploy-config/target'
require 'deploy-config/manifest'

module DeployConfig
  class << self
    # Load manifest from file
    # @param path [String] source filename
    # @return [Manifest] manifest instance
    def load_file(path)
      full_path = File.expand_path(path)
      ext = File.extname(path).downcase.delete('.')

      if !File.exists?(full_path)
        raise ArgumentError, "File does not exist"
      end

      if !%w(json yml yaml).include?(ext)
        raise ArgumentError, "Invalid file format"
      end

      data = File.read(full_path)
      self.send("from_#{ext}".to_sym, data)
    end

    # Parse manifest from yaml data
    # @param data [String] source string
    # @return [Manifest] manifest instance
    def from_yml(data)
      Manifest.new(YAML.load(data))
    end

    alias :from_yaml :from_yml

    # Parse manifest from json data
    # @param data [String] source string
    # @return [Manifest] manifest instance
    def from_json(data)
      # TODO: Impement JSON loader
      raise RuntimeErrorm "JSON loader is not implemented"
    end
  end
end