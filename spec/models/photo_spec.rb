require 'spec_helper'

describe Photo do
  # attributes
  it { should respond_to(:desc) }
  it { should respond_to(:image) }
  it { should respond_to(:score) }
  # methods
  it { should respond_to(:url) }
  it { should respond_to(:score_up) }
  it { should respond_to(:age) }
end