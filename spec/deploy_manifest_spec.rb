require 'spec_helper'

describe DeployManifest do
  it { should respond_to :load_file }
  it { should respond_to :from_json }
  it { should respond_to :from_xml  }
  it { should respond_to :from_yml  }
end