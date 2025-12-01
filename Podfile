# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'QuickStart' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for QuickStart
  pod 'JuggleIM', '1.8.28.1'
  pod 'MBProgressHUD', '1.1.0'
  pod 'Masonry', '1.1.0'
  pod 'SDWebImage', '5.20.0'
  pod 'JZegoCall', '1.8.25'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # 替换为你项目的最低部署版本（如 '11.0'）
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
