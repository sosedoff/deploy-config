require 'spec_helper'

describe DeployConfig do
  it { should respond_to :load_file }
  it { should respond_to :from_json }
  it { should respond_to :from_yml  }
  it { should respond_to :from_yaml }
end