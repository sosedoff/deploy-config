require 'spec_helper'

class Validator
  include DeployManifest::Validations
end

describe DeployManifest::Validations do
  let(:tester) { Validator.new }

  it { should respond_to :validate_app_name }
  it { should respond_to :validate_app_type }
  it { should respond_to :validate_git_url  }

  it 'validates application name' do
    tester.validate_app_name('foo').should be_true
    tester.validate_app_name('foo-bar').should be_true
    tester.validate_app_name('foo_bar').should be_true
    tester.validate_app_name('foo-bar_10').should be_true
    tester.validate_app_name('foo bar').should be_false
    tester.validate_app_name('foo "bar"').should be_false
    tester.validate_app_name("foobar\nbarfoo").should be_false
  end

  it 'validates application type' do
    tester.validate_app_type('static').should be_true
    tester.validate_app_type('rack').should be_true
    tester.validate_app_type('rails3').should be_true
    tester.validate_app_type('sinatra').should be_true
    tester.validate_app_type('wordpress').should be_true
    tester.validate_app_type('cakephp').should be_true
    tester.validate_app_type('django').should be_true
  end

  it 'validates git source url' do
    tester.validate_git_url('git@hostname.com:repo.git').should be_true
    tester.validate_git_url('git@github.com:user/repo.git').should be_true
    tester.validate_git_url('git@hostname.com:repo').should be_false
    tester.validate_git_url('hostname.com:repo.git').should be_false
  end
end