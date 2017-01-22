platform :ios, '10.2'

workspace 'Tasks'

target 'CVApp' do
  project 'CVApp.xcodeproj'

  use_frameworks!

  pod 'ALAccordion'
  pod 'SwiftHEXColors'
end

target 'WeatherApp' do
  project 'WeatherApp.xcodeproj'

  use_frameworks!

  pod 'SwiftHEXColors'

  plugin 'cocoapods-keys', {
    :project => 'WeatherApp',
    :keys => [
      'OpenWeatherMapAPIKey'
    ]
  }
end
