require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'capybara/cucumber'
require 'pry'
require 'faker'
require 'cpf_faker'
require 'brstring'
require 'fileutils'
require 'logger'
require 'capybara-screenshot/rspec'
require 'site_prism'
require 'base64'
require 'correios-cep'
require 'appium_capybara'
require 'browserstack/local'

PATH_API_REST = 'aut-api-rest/'
require_relative '../../aut-api-rest/lib/apirest/apirest'

Dir[File.join(File.dirname(__FILE__), 'spec_helper/*.rb')].sort.each {|file| require file}
Dir[File.join(File.dirname(__FILE__), 'elements/**/*.rb')].sort.each {|file| require file}
Dir[File.join(File.dirname(__FILE__), 'assertion/*.rb')].sort.each {|file| require file}
Dir[File.join(File.dirname(__FILE__), 'utils/*.rb')].sort.each {|file| require file}

ENV['LOG_FULL'].nil? ? LOG_FULL = false : LOG_FULL = true
ENV['IOS'].nil? ? IOS = false : IOS = true
ENV['ANDROID'].nil? ? ANDROID = false : ANDROID = true
ENV['AMBIENTE'] ? AMBIENTE = ENV['AMBIENTE'] : 'Ambiente não informado'


VM_NODE ||= ENV['VM_NODE'] ||= ''
BANDEIRA ||= ENV['BANDEIRA']
REMOTE ||= ENV['REMOTE'] || false


def app_name

  jenkins_app_version = ENV['ENV_APP_VERSION']

  if jenkins_app_version == 'Default'
    version = 0

    unless ENV['APP_VERSION'].nil?
      version = ENV['APP_VERSION']
    end

    platform = 'android'
    if IOS
      platform = 'ios'
    end

    app_caps = "#{BANDEIRA}-#{AMBIENTE}-#{platform}-#{version}"
  else
    jenkins_app_version
    app = jenkins_app_version.split('*')
    app = app[0].strip
    app_caps = app
  end
  app_caps
end

def local_app_name
  case BANDEIRA
  when 'casasbahia'
    if IOS
      app_caps = 'CasasBahia.app'
    else
      app_caps = 'app-bahia-debug.apk'
    end
  when 'pontofrio'
    if IOS
      app_caps = 'PontoFrio.app'
    else
      app_caps = 'app-pontofrio-debug.apk'
    end
  end
  app_caps
end

$username = 'mobileqa5'
$access_key = "RJqeDMeCG1SUVdZx5LQB"

def set_browserstack_local_connection
  time = Time.now
  time = time.to_f
  local_identifier = time

  $bs_local = BrowserStack::Local.new
  $bs_local_args = { "key" => $access_key , "localIdentifier" => local_identifier.to_s}

  $bs_local.start($bs_local_args)

  local_identifier.to_s
end

def set_browserstack_device jenkins_platform_version, jenkins_platform_device
  bs = BrowserstackDevices.new
  device = bs.get_random_device jenkins_platform_version, jenkins_platform_device
  device
end

def set_browserstack_caps
  local_identifier = set_browserstack_local_connection
  bs_caps = {}

  bs_caps['app'] = app_name
  bs_caps['build'] = ENV['BUILD']
  bs_caps['browserstack.local'] = true
  bs_caps['browserstack.localIdentifier'] = local_identifier
  bs_caps['browserstack.debug'] = true
  bs_caps["real_mobile"] = true
  bs_caps['autoAcceptAlerts'] = true


  jenkins_platform_version = ENV['ENV_PLATFORM_OS_VERSION']
  jenkins_platform_device = ENV['ENV_DEVICE']

  if jenkins_platform_version == 'Random' || jenkins_platform_device == 'Random'
    device = set_browserstack_device jenkins_platform_version, jenkins_platform_device
    os = device.fetch('os')
    os_version = device.fetch('os_version')
    device = device.fetch('device')

    bs_caps['os'] = os
    bs_caps['os_version'] = os_version
    bs_caps['device'] = device
  elsif jenkins_platform_version == 'Default' || jenkins_platform_device == 'Default'
    if IOS
      bs_caps['device'] = 'iPhone 8 Plus'
      bs_caps['os_version'] = '11.0'
    else
      bs_caps['device'] = 'Samsung Galaxy Note 9'
      bs_caps['os_version'] = '8.1'
    end
  else
    bs_caps['device'] = jenkins_platform_device
    bs_caps['os_version'] = jenkins_platform_version
  end

  bs_caps
end




$caps = set_browserstack_caps

def set_local_caps
  local_caps = {}


  if IOS
    local_caps['deviceName'] = 'iPhone 8 - 12.1'
    local_caps['udid'] = '93FC481C-B87C-4351-B394-A1533F89E958'
    local_caps['platformName'] = 'iOS'
    local_caps['platformVersion'] = '12.1'
    local_caps['automationName'] = 'XCUITest'
    local_caps['autoAcceptAlerts'] = true
    local_caps['app'] = local_app_name
  else
    local_caps['deviceName'] = 'Emulator'
    local_caps['platformName'] = 'Android'
    local_caps['platformVersion'] = '8.0'
    local_caps['udid'] = '192.168.56.101:5555'
    local_caps['app'] = local_app_name
    local_caps['appActivity'] = 'br.com.viavarejo.feature.home.HomeActivity'
  end
  local_caps['newCommandTimeout'] = 10000
  local_caps['fullReset'] = true
  local_caps['noReset'] = false

  local_caps
end

$local_caps = set_local_caps


def set_driver
  if REMOTE
    use_caps = $caps
    use_url = "http://#{$username}:#{$access_key}@hub-cloud.browserstack.com/wd/hub"
  else
    use_caps =  $local_caps
    use_url = "http://127.0.0.1:4723/wd/hub"
  end
  driver = Appium::Driver.new({
                                  'caps' => use_caps,
                                  'appium_lib' => {
                                      :server_url => use_url
                                  }}, true)
  driver
end

$appium_driver = set_driver

def start_appium
  begin
    $appium_driver.start_driver
  rescue StandardError
    sleep 5
    puts "Retrying - Launching Appium"
    $appium_driver.start_driver

  end
end

$driver = start_appium


World(Comercio, Commons, ClickEl, SendKeys, Keyboard, Select, CheckVisibility, CheckData, FindEl, AssertAndPrint)
