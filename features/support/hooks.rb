require 'open-uri'
require 'prawn'
require 'capybara-screenshot/rspec'
require 'base64'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'


SitePrism::Page.class_eval do
  include Commons, Comercio, ClickEl, SendKeys, Keyboard, Select, CheckVisibility, CheckData, FindEl, Alerts, Iframes, WaitElement, AssertAndPrint
end

SitePrism::Section.class_eval do
  include Commons, Comercio, ClickEl, SendKeys, Keyboard, Select, CheckVisibility, CheckData, FindEl, Alerts, Iframes, WaitElement, AssertAndPrint
end

=begin
Screenshots.class_eval do
  include Commons
end
=end

$pdf_names = []

Before do |scenario|
  $LOG = Logger.new('automation_log.log')
  $count_img_scenario = 0

  ## Create directory for saved screenshots
  #create_directory_evidences(scenario)
  $Scenario = scenario

  tracing '---- Executando Cenário: ' + scenario.name.to_s.center(5).upcase

end

def start_appium
  begin
    $appium_driver.start_driver
  rescue StandardError
    sleep 5
    puts "Retrying - Launching Appium"
    $appium_driver.start_driver

  end
end

After do |scenario|
  time = Time.now
  time = time.to_f
  identifier = time

  file_path = "screenshot_#{identifier}.png"
  $appium_driver.screenshot file_path

  image = open(file_path, 'rb', &:read)
  encoded_image = Base64.encode64(image)
  embed(encoded_image, 'image/png;base64', 'SCREENSHOT')

  $driver.reset

end





at_exit do
  $bs_local.stop
  $driver.quit
end

