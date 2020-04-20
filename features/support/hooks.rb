
After do
  # Capybara.current_session.driver.quit
end

Before do
  if STACK.nil?
    #  Limpar cookies e cache session browser
    browser = Capybara.current_session.driver.browser
    if BROWSER != 'poltergeist'
      if browser.respond_to?(:clear_cookies)
        #  Rack::MockSession
        browser.clear_cookies
      elsif browser.respond_to?(:manage) && browser.manage.respond_to?(:delete_all_cookies)
        #  Selenium::WebDriver
        browser.manage.delete_all_cookies
      else
        raise 'Não Limpou cookies'
      end
    end
  end
end
