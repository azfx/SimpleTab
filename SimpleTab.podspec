#
# Be sure to run `pod lib lint SimpleTab.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SimpleTab"
  s.version          = "0.2.0"
  s.summary          = "A Simple iOS Tab Bar Controller with animation support."
  s.description      = <<-DESC
                        SimpleTab is a simple tab bar controller for iOS 8 and above, which extends the default UITabBarController class with customization support for :
                        * Tab Item Custom UI
                        * Tab Item Animations
                        * View Transitions
                       DESC
  s.homepage         = "https://github.com/azfx/SimpleTab"
  s.license          = 'MIT'
  s.author           = { "azfx" => "abdul.zalil@gmail.com" }
  s.source           = { :git => "https://github.com/azfx/SimpleTab.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SimpleTab' => ['Pod/Assets/*.png']
  }

end
