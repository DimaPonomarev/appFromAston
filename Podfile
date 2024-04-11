# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'BettaBank' do
  pod 'SnapKit'
  pod 'SwiftLint'
  pod 'YandexMapsMobile', '4.4.0-lite'
  pod 'KeychainSwift'
end

target 'BettaBankTests' do
  pod 'SnapKit'
  pod 'SwiftLint'
  pod 'YandexMapsMobile', '4.4.0-lite'
  pod 'KeychainSwift'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
