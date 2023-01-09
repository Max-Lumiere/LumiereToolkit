#
# Be sure to run `pod lib lint LumiereToolkit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LumiereToolkit'
  s.version          = '0.2.0'
  s.summary          = 'Some low level useful stuff'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Tools for work with common things, as threads, creation, initialization, some UI helpers
                       DESC

  s.homepage         = 'https://github.com/Max-Lumiere/LumiereToolkit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Max Svetlov' => 'maxim.s.svetlov@gmail.com' }
  s.source           = { :git => 'git@github.com:Max-Lumiere/LumiereToolkit.git', :tag => s.version.to_s }


  s.ios.deployment_target = '14.0'
  s.osx.deployment_target = '12.0'
#  s.watchos.deployment_target = '9.0'
  s.tvos.deployment_target = '15.0'
  s.swift_versions = "5.7"

  s.source_files = 'LumiereToolkit/Sources/**/*'
  s.ios.source_files = 'LumiereToolkit/Sources_iOS/**/*'
  
  # s.resource_bundles = {
  #   'LumiereToolkit' => ['LumiereToolkit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
