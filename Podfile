# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Pander' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
pod 'SVPullToRefresh'
pod 'MBProgressHUD', '~> 1.0.0'
pod 'CocoaLumberjack/Swift'
pod 'Fabric'
pod 'Crashlytics'
pod 'SwiftyJSON'
pod 'ActionSheetPicker-3.0'
pod 'AFNetworking', '~> 2.5'
pod 'ReachabilitySwift', '~> 3'
pod 'KGModal', '~> 0.0.1'
pod 'MGSwipeTableCell'
pod 'TPKeyboardAvoiding'
pod 'Alamofire', '~> 4.5'
pod 'IQKeyboardManagerSwift'
pod 'BIObjCHelpers', '~> 0.4'
pod 'FSCalendar'
pod 'HMSegmentedControl'
pod 'HCSStarRatingView', '~> 1.5'
pod 'SDWebImage', '~> 4.0'
pod 'AAPickerView'
pod 'FBSDKLoginKit'
pod 'FacebookCore'
pod 'FacebookLogin'
pod 'FacebookShare'
pod 'GoogleSignIn'
pod 'PWSwitch'
pod 'NVActivityIndicatorView'
pod 'PINCache'
pod 'ToggleView', '~> 0.0.1'
pod 'TextFieldEffects'
pod 'CarbonKit'


  # Pods for Pander

  target 'PanderTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PanderUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
