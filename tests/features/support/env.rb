require 'capybara'
require 'capybara/cucumber'

Capybara.configure do |config|
    config.default_driver = :selenium_chrome
    config.app_host = ENV['URL']
    config.default_max_wait_time = 10
end
