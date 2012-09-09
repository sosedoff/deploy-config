require 'spec_helper'

describe DeployManifest::Manifest do
  it { should respond_to :app }
  it { should respond_to :app_type }
  it { should respond_to :git }
  it { should respond_to :original_data }

  describe 'initialization' do
    it 'keeps the original data' do
      make_manifest(:foo => 'bar').original_data.should be_a Hash
    end
  end

  describe 'parser' do
    it 'raises error on invalid source' do
      expect { make_manifest(nil).parse! }.to raise_error
      expect { make_manifest('').parse!  }.to raise_error
      expect { make_manifest({}).parse!  }.to raise_error
    end

    it 'requires app config' do
      expect { make_manifest({}).parse! }.to raise_error "App is not defined"
      expect { make_manifest(:app => {}).parse! }.to raise_error "App name required"
      expect { make_manifest(:app => {:name => "foo"}).parse! }.to raise_error "App type required"
      expect { make_manifest(:app => {:name => "foo", :type => "rails3"}).parse! }.to raise_error "App source required"
      expect { make_manifest(:app => {:name => "foo", :type => "rails3", :git => "git@host.com:foo.git"})}.not_to raise_error
    end
  end
end