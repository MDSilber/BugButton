#
# Be sure to run `pod spec lint BugButton.podspec' to ensure this is a
# valid spec.
#
# Remove all comments before submitting the spec. Optional attributes are commented.
#
# For details see: https://github.com/CocoaPods/CocoaPods/wiki/The-podspec-format
#
Pod::Spec.new do |s|
  s.name         = "BugButton"
  s.version      = "1.0.0"
  s.summary      = "A custom iOS button for users to report bugs during beta testing"
  s.homepage     = "https://github.com/MDSilber/BugButton"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Mason Silber" => "mdsilber1@gmail.com" }
  s.source       = { :git => "https://github.com/MDSilber/BugButton", :tag => "1.0.0" }
  s.platform     = :ios, '5.0'
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.public_header_files = 'Classes/**/*.h'
  s.resources = "Resources/*.png"
  s.requires_arc = true
end
