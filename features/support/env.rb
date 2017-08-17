require 'cucumber'
require 'minitest/spec'
require 'capybara/rspec/matchers'
require 'capybara/angular'
require 'selenium-webdriver'

Users = YAML::load(File.read("#{File.dirname(__FILE__)}/../../config/users.yaml"))
Environment = YAML::load(File.read("#{File.dirname(__FILE__)}/../../config/environments.yaml"))[(ENV['env'] || 'qe')]
$reporterConf = YAML::load(ERB.new(File.read("#{File.dirname(__FILE__)}/../../config/reporter.yaml.erb")).result)
Reset_session = (ENV['reset' || 'false']) == 'true'
JS_Errors = (ENV['js_errors'] || 'all')
JS_Whitelist = YAML::load(File.read("#{File.dirname(__FILE__)}/../../config/js_whitelist.yaml"))
DL_Path = File.absolute_path("#{File.dirname(__FILE__)}/../../downloads")
FilesDirectory = "#{File.dirname(__FILE__)}/../../files"

class MinitestWorld
  extend Minitest::Assertions
  attr_accessor :assertions

  def initialize
    self.assertions = 0
  end
end

World do
  MinitestWorld.new
end

class DriverJSError < StandardError; end

WaitTime  = (ENV['wait'] || 7).to_i

Capybara.configure do |config|
  config.match                    = :prefer_exact
  config.ignore_hidden_elements   = true
  config.exact_options            = true
  config.visible_text_only        = true
  config.default_driver           = :selenium
  config.app_host                 = "http#{'s' if Environment[:secure]}://#{Environment[:host]}"
  config.run_server               = false
  config.default_max_wait_time    = WaitTime
  config.default_host             = Capybara.app_host
  config.default_selector         = :css
  config.automatic_reload         = true
  config.reuse_server             = true
end

Capybara.register_driver :chrome do |app|
  profile = Selenium::WebDriver::Chrome::Profile.new
  profile["download.default_directory"] = DL_Path.to_s
  Capybara::Selenium::Driver.new(app, :browser => :chrome, :profile => profile)
end

Capybara.register_driver :safari do |app|
  Capybara::Selenium::Driver.new(app, :browser => :safari)
end

Capybara.register_driver :edge do |app|
  Capybara::Selenium::Driver.new(app, :browser => :edge)
end

Capybara.register_driver :ie do |app|
  Capybara::Selenium::Driver.new(app, :browser => :internet_explorer)
end

Capybara.default_driver = (ENV['driver'] || 'chrome').to_sym

require "#{File.dirname(__FILE__)}/lib/helpers/logger.rb"
if ENV['logfile'] then
  $logger = Tracker.new({file: ENV['logfile'], on: true})
elsif ENV['logdir'] then
  $logdir = ENV['logdir']
  Dir.mkdir $logdir unless Dir.exist? $logdir
  if File.exists?("#{$logdir}/run_info.log") then
    File.truncate "#{$logdir}/run_info.log", 0
  end
  $logger = Tracker.new({file: "#{$logdir}/run_info.log", on: true})
else
  Tracker.new
end
