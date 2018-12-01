use_frameworks!
platform :ios, '12.0'

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

target 'Study Spot' do
	pod 'Cosmos', '~> 17.0'
    pod 'DGCollectionViewLeftAlignFlowLayout'
    pod 'Firebase/Core'
    pod 'Firebase/Firestore'
end
