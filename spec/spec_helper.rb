require 'radler'

Dir[Radler.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.color_enabled = true
  config.order = "random"
  config.filter_run_including :focus => true
  config.run_all_when_everything_filtered = true
end
