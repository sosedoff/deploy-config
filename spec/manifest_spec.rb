require 'spec_helper'

describe DeployManifest::Manifest do
  it { should respond_to :app }
  it { should respond_to :app_type }
  it { should respond_to :git }
  it { should respond_to :deploy_mode }
  it { should respond_to :data }

  describe 'initialization' do
    it 'keeps the original data' do
      make_manifest(:foo => 'bar').data.should be_a Hash
    end
  end

  describe 'validation' do
    it 'raises error on invalid source' do
      expect { make_manifest(nil).validate }.to raise_error
      expect { make_manifest('').validate  }.to raise_error
      expect { make_manifest({}).validate  }.to raise_error
    end
  end
end