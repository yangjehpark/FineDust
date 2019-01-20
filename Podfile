# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
use_frameworks!

target 'FineDust' do

    pod 'Alamofire', '= 4.7.0'
    pod 'Kingfisher', '= 4.6.0'
    pod 'FLEX', '2.4.0'
    pod 'ObjectMapper', '= 3.4.1'
    pod 'AlamofireObjectMapper', '= 5.2.0'
    pod 'SideMenu', '= 3.1.5'
    pod 'NVActivityIndicatorView', '= 4.2.1'
    pod 'PagingView', '= 0.5.1'
    pod 'BWWalkthrough', '= 2.1.2'
    pod 'CryptoSwift', '= 0.13.1'

end

target 'FineDustTests' do
    
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'PagingView'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
        if target.name == 'BWWalkthrough'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end
