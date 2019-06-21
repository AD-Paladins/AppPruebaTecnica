target 'PruebaTecnicaTech' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PruebaTecnicaTech
  
  pod 'PKHUD', '~> 5.0'
  pod 'Alamofire', '~> 4.7'
  pod 'SDWebImage', '~> 4.0'
  pod 'SwiftDate', '~> 5.0'
  pod 'SwiftMessages'  
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        end
    end
end
