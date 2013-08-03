require 'spec_helper'

describe Radler do
  describe 'self.root' do
    subject { Radler.root }
    it { should be_a Pathname }
  end

  describe 'self.settings' do
    subject { Radler.settings }
    it { should be_a Radler::Settings }
  end
end