require 'spec_helper'

class Tester
  include DeployConfig::Parser
  include DeployConfig::Validations
end

describe DeployConfig::Parser do
  let(:tester) { Tester.new }

  it 'parses application configuration' do
    expect { tester.parse_application({}) }.to raise_error "App name required"
    expect { tester.parse_application(:name => "foo") }.to raise_error "App type required"
    expect { tester.parse_application(:name => "foo", :deploy => "rails3") }.to raise_error "App source required"
    expect { tester.parse_application(:name => "foo", :deploy => "rails3", :git => "git@host.com:foo.git") }.not_to raise_error
  end
end