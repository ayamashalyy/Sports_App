# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'Sportify' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Sportify
  pod 'ReachabilitySwift'
  pod 'lottie-ios'
  pod 'Kingfisher'
  pod 'Alamofire'

  target 'SportifyTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SportifyUITests' do
    # Pods for testing
  end

end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 13.0
config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
end
end
end
end
