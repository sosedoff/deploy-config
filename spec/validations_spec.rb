require 'spec_helper'

class Validator
  include DeployManifest::Validations
end

describe DeployManifest::Validations do
  it { should respond_to :validate_app_name }
  it { should respond_to :validate_app_type }
  it { should respond_to :validate_git_url  }

  describe 'validations' do
    let(:tester) { Validator.new }

    it 'validates application name' do
      pending
    end

    it 'validates application type' do
      pending
    end

    it 'validates git source url' do
      pending
    end
  end
end