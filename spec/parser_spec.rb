require 'spec_helper'

class Tester
  include DeployManifest::Parser
  include DeployManifest::Validations
end

describe DeployManifest::Parser do
  let(:tester) { Tester.new }

  it 'parses application configuration' do
    expect { tester.parse_application({}) }.to raise_error "App name required"
    expect { tester.parse_application(:name => "foo") }.to raise_error "App type required"
    expect { tester.parse_application(:name => "foo", :type => "rails3") }.to raise_error "App source required"
    expect { tester.parse_application(:name => "foo", :type => "rails3", :git => "git@host.com:foo.git") }.not_to raise_error
  end
end