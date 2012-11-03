require 'spec_helper'

class Validator
  include DeployConfig::Validations
end

describe DeployConfig::Validations do
  let(:tester) { Validator.new }

  it { should respond_to :valid_app_name? }
  it { should respond_to :valid_app_type? }
  it { should respond_to :valid_git_url?  }

  it 'validates application name' do
    tester.valid_app_name?('foo').should be_true
    tester.valid_app_name?('foo-bar').should be_true
    tester.valid_app_name?('foo_bar').should be_true
    tester.valid_app_name?('foo-bar_10').should be_true
    tester.valid_app_name?('foo bar').should be_false
    tester.valid_app_name?('foo "bar"').should be_false
    tester.valid_app_name?("foobar\nbarfoo").should be_false
  end

  it 'validates application type' do
    tester.valid_app_type?('static').should be_true
    tester.valid_app_type?('rack').should be_true
    tester.valid_app_type?('rails3').should be_true
    tester.valid_app_type?('sinatra').should be_true
    tester.valid_app_type?('wordpress').should be_true
    tester.valid_app_type?('cakephp').should be_true
    tester.valid_app_type?('django').should be_true
  end

  it 'validates git source url' do
    tester.valid_git_url?('git@hostname.com:repo.git').should be_true
    tester.valid_git_url?('git@github.com:user/repo.git').should be_true
    tester.valid_git_url?('git@hostname.com:repo').should be_false
    tester.valid_git_url?('hostname.com:repo.git').should be_false
  end
end