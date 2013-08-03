require "radler/version"
require "radler/command_line_app"
require "radler/settings"
require "radler/vault_archive"

require 'fog'
require "date"

module Radler
  SIMPLEDB_DOMAIN = 'radler-backups'.freeze

  def self.root
    Pathname.new('.').expand_path
  end

  def self.settings
    @settings ||= Settings.new
  end
end
