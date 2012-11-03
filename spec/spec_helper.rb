$:.unshift File.expand_path("../..", __FILE__)

require 'lib/deploy-config'

def fixture_path(filename=nil)
  path = File.expand_path("../fixtures", __FILE__)
  filename.nil? ? path : File.join(path, filename)
end

def fixture(file)
  File.read(File.join(fixture_path, file))
end

def make_manifest(data)
  DeployManifest::Manifest.new(data)
end