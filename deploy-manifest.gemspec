require File.expand_path('../lib/deploy-manifest/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "deploy-manifest"
  s.version     = DeployManifest::VERSION
  s.summary     = "Deployment manifest"
  s.description = "Deployment manifest"
  s.homepage    = "http://github.com/sosedoff/deploy-manifest"
  s.authors     = ["Dan Sosedoff"]
  s.email       = ["dan.sosedoff@gmail.com"]
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec',     '~> 2.11'
  s.add_development_dependency 'simplecov', '~> 0.4'

  s.add_runtime_dependency 'hashr', '~> 0.0.22'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  s.require_paths = ["lib"]
end