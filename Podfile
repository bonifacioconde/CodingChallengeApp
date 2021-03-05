# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'CodingChallengeApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CodingChallengeApp
  pod 'Moya', '13.0.1'#, '~> 13.0'
  pod 'Kingfisher', '4.10.1'#, '~> 4.0'
  pod 'Realm', '4.3.2'#, git: 'https://github.com/realm/realm-cocoa.git', branch: 'master', submodules: true
  pod 'RealmSwift', '4.3.2'#, git: 'https://github.com/realm/realm-cocoa.git', branch: 'master', submodules: true
  pod 'SwiftLint', '0.39.1'
  pod 'R.swift', '5.0.1'
  
  target 'CodingChallengeAppTests' do
    #inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
    pod 'Realm/Headers'
    pod 'Moya', '13.0.1'
  end
  
end

post_install do |installer|
  
  puts "Removing static analyzer support for all targets."
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        config.build_settings['OTHER_CFLAGS'] = "$(inherited) -Qunused-arguments -Xanalyzer -analyzer-disable-all-checks"
    end
  end
  
#  puts "  Using Swift 5.0 for targets:"
#  installer.pods_project.targets.each do |target|
#    if ['NameOfPodHere'].include? target.name
#      puts "   - #{target.name}"
#      target.build_configurations.each do |config|
#        config.build_settings['SWIFT_VERSION'] = '5.0'
#      end
#    end
#  end

end

