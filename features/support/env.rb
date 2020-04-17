require 'cucumber'
require 'rspec'
require 'capybara'
require 'capybara-screenshot'
require 'capybara-screenshot/cucumber'
require 'capybara/cucumber'
require 'site_prism'
require 'selenium-webdriver'
require 'yaml'
require 'capybara/rspec'
require 'pry'
require 'parallel'
require 'rubygems'
require 'nokogiri'
require 'capybara/poltergeist'
require 'phantomjs'
require 'parallel_cucumber'
require 'oci8'
require 'phantomjs'
# require 'faker'
# require 'br_documents'
# require 'special_char_remover'
# require 'pdf-reader'
# require 'date'
# require 'open-uri'
# require 'titleize'
# require 'rake'
# require 'capybara/dsl'
# require 'httparty'
# require 'json'
# require 'base64'
# require 'rest-client'
# require 'site_prism'

BROWSER = ENV['BROWSER']

ENV['TAGS']
ENV['QTD_BROWSERS']

#  Rodar no browser Chrome
# if BROWSER.eql?('chrome') || BROWSER.nil?
#   Capybara.register_driver :selenium_chrome do |app|
#     prefs = {
#       download: {
#         prompt_for_download: false,
#         directory_upgrade: true,
#         default_directory: File.expand_path('./PDF')
#       },
#       plugins: {
#         always_open_pdf_externally: true,
#         plugins_disabled: ['Chrome PDF Viewer', 'Adobe Flash Player']
#       }
#     }
#     capabilities = Selenium::WebDriver::Remote::Capabilities.chrome('chromeOptions' => {
#        'prefs' =>  prefs, 'args' => [
#          '--start-maximized',
#          '--disable-infobars',
#          '--disable-notifications',
#          '--disable-password-generation --disable-password-manager-reauthentication',
#          '--disable-password-separated-signin-flow',
#          '--disable-popup-blocking',
#          '--disable-translate',
#          '--disable-save-password-bubble',
#          '--ignore-certificate-errors',
#          '--print-to-pdf'
#        ] })
#     Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
#   end
#   Capybara.default_driver = :selenium_chrome
#   Capybara.javascript_driver = :selenium_chrome
#
#   elsif BROWSER.eql?('poltergeist')
#     binding.pry
#     Capybara::Poltergeist::Driver.new(app, poltergeist_options)
# end

Capybara.register_driver :selenium do |app|
  if BROWSER.eql?('chrome') || BROWSER.nil?
    prefs = {
      download: {
        prompt_for_download: false,
        directory_upgrade: true,
        default_directory: File.expand_path('./PDF')
      },
      plugins: {
        always_open_pdf_externally: true,
        plugins_disabled: ['Chrome PDF Viewer', 'Adobe Flash Player']
      }
    }
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome('chromeOptions' => {
       'prefs' =>  prefs, 'args' => [
         '--start-maximized',
         '--disable-infobars',
         '--disable-notifications',
         '--disable-password-generation --disable-password-manager-reauthentication',
         '--disable-password-separated-signin-flow',
         '--disable-popup-blocking',
         '--disable-translate',
         '--disable-save-password-bubble',
         '--ignore-certificate-errors',
         '--print-to-pdf'
       ] })
    Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
  elsif BROWSER.eql?('poltergeist')
    poltergeist_options = {
      js_errors: false,
      phantomjs_logger: File.open('log/test_phantomjs.log', 'a'),
      phantomjs_options: ['--ignore-ssl-errors=true'],
      window_size: [1440, 2000],
      screen_size: [1440, 2000]
    }
    Capybara::Poltergeist::Driver.new(app, poltergeist_options)
  end
end

Capybara.configure do |config|
  config.default_driver = :selenium
  config.javascript_driver = :selenium
end

@login = 'login_default'
$massa_default_login = YAML.load_file('./features/support/config/massa_login.yaml')[@login]

Capybara.default_max_wait_time = 120
