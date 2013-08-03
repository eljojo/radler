require 'spec_helper'

describe Radler::VaultArchive do
  describe 'self.from_inventory' do
    subject { Radler::VaultArchive.from_inventory(glacier_inventory_factory) }
    it { should be_a Array }
    its(:first) { should_not be_nil }
    its(:first) { should be_a Radler::VaultArchive }
  end

  describe 'initialize' do
    subject { Radler::VaultArchive.new(archive_id: '1234abc') }
    its(:archive_id) { should eq '1234abc' }
  end
end