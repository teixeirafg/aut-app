class BrowserstackDevices
  include HTTParty

  basic_auth ENV['BROWSERSTACK_USERNAME'], ENV['BROWSERSTACK_ACCESS_KEY']
  headers 'Content-Type' => 'application/json'
  base_uri "https://api-cloud.browserstack.com/app-automate"


  def get_random_device jenkins_platform_version, jenkins_platform_device
    devices = []

    if jenkins_platform_device == 'Random'
      devices = random_version_and_device
    elsif jenkins_platform_version == 'Random'
      devices_version = []
      devices = random_version_and_device
      devices.each do |x|
        if x.fetch('os_version') == jenkins_platform_version.downcase!
          devices_version << x
        end
      end
      devices = devices_version
    end

    devices
  end

  def random_version_and_device
    random_devices = []

    platform = 'android'
    if IOS
      platform = 'ios'
    end

    begin
      response = self.class.get("/devices.json")

      bs_devices = response.parsed_response
      bs_devices.each do |x|
        if x.fetch('os') == platform.downcase
          if x.fetch('realMobile')
            random_devices << x
          end
        end
      end

      random_devices.sample

    rescue StandardError
      random_devices << 'error'
    end

  end


end