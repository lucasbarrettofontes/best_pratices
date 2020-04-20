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
require 'ffi'
require 'rubygems'
require 'selenium-webdriver'
require 'browser_stack'
# require 'browserstack/local'
#require 'parallel'
# require 'rubygems'
# require 'nokogiri'
require 'capybara/poltergeist'
# require 'phantomjs'
# require 'parallel_cucumber'
# require 'oci8'
# require 'phantomjs'
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
STACK   = ENV['STACK']

ENV['TAGS']
ENV['QTD_BROWSERS']

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
  elsif BROWSER.eql?('firefox')
    Capybara::Selenium::Driver.new(app, browser: :firefox)    
  end
end

if BROWSER.eql?('Chrome') and STACK.eql?('stack') or BROWSER.eql?('Firefox') and STACK.eql?('stack')
  # Browser Stack   
  # monkey patch to avoid reset sessions
  class Capybara::Selenium::Driver < Capybara::Driver::Base
    def reset!
      if @browser
        @browser.navigate.to('about:blank')
      end
    end
  end

  TASK_ID = (ENV['TASK_ID'] || 0).to_i
  CONFIG_NAME = ENV['CONFIG_NAME'] || 'single'
  CONFIG = YAML.load(File.read(File.join(File.dirname(__FILE__), "config/#{CONFIG_NAME}.yml")))
  CONFIG['user'] = ENV['BROWSERSTACK_USERNAME'] || CONFIG['user']
  CONFIG['key'] = ENV['BROWSERSTACK_ACCESS_KEY'] || CONFIG['key']
  
  Capybara.register_driver :browserstack do |app|
    @caps = CONFIG['common_caps'].merge(CONFIG['browser_caps'][TASK_ID])

    # Code to start browserstack local before start of test
    if @caps['browserstack.local'] && @caps['browserstack.local'].to_s == 'true';
      @bs_local = BrowserStack::Local.new
      bs_local_args = {"key" => "#{CONFIG['key']}"}
      @bs_local.start(bs_local_args)
    end

    Capybara::Selenium::Driver.new(app,
      :browser => :remote,
      :url => "http://#{CONFIG['user']}:#{CONFIG['key']}@#{CONFIG['server']}/wd/hub",
      :desired_capabilities => @caps
    )
  end
end

if STACK.eql?('stack')
  Capybara.default_driver = :browserstack
else
  Capybara.configure do |config|
    config.default_driver = :selenium
    config.javascript_driver = :selenium
  end
end

@login = 'login_default'
$massa_default_login = YAML.load_file('./features/support/config/massa_login.yaml')[@login]

Capybara.default_max_wait_time = 15