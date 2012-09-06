require 'rubygems'
require 'yaml'
require 'hashr'

require 'deploy-manifest/version'
require 'deploy-manifest/errors'
require 'deploy-manifest/helpers'
require 'deploy-manifest/validations'
require 'deploy-manifest/parser'
require 'deploy-manifest/manifest'

module DeployManifest
  class << self
    # Load manifest from file
    # @param path [String] source filename
    # @return [Manifest] manifest instance
    def load_file(path)
      full_path = File.expand_path(path)
      ext  = File.extname(full_path, File.basename(full_path)).downcase

      if !File.exists?(full_path)
        raise ArgumentError, "File does not exist"
      end

      if !%w(json yml xml).include?(ext)
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

    # Parse manifest from json data
    # @param data [String] source string
    # @return [Manifest] manifest instance
    def from_json(data)
      # TODO: Impement JSON loader
    end

    # Parse manifest from xml data
    # @param data [String] source string
    # @return [Manifest] manifest instance
    def from_xml(data)
      # TODO: Implement XML loader
    end
  end
end