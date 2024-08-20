# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DigioChallenge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DigioChallenge
  pod 'SwiftLint'

  target 'DigioChallengeTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.name == 'DigioChallenge'
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_LINT'] = 'swiftlint'
        end
      end
    end
  end

end
