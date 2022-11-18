#
# Be sure to run `pod lib lint XAnimation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XAnimation'
  s.version          = '0.1.1'
  s.summary          = 'XAnimation based on opensorce airbnb Lottie to apply AE Animation to yourself layer.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Use XAnimation you can run lottie file effect on yourself view or layer. that means whatever view or layer exsits can attach lottie animation effect without modify your own logic. it's cool?
                       DESC

  s.homepage         = 'https://github.com/JDFED/XAnimation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache License 2.0', :file => 'LICENSE' }
  s.author           = { 'wangxiyuan' => 'wangxiyuan613@163.com' }
  s.source           = { :git => 'https://github.com/JDFED/XAnimation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'XAnimation/Classes/**/*'
  s.resources = 'XAnimation/Classes/**/*'
  # s.resource_bundles = {
  #   'XAnimation' => ['XAnimation/Assets/*.png']
  # }

  s.static_framework  =  true
#  # arc和mrc选项
  s.requires_arc = true
#  # 链接设置 重要
#  s.xcconfig = {'OTHER_LDFLAGS' => '-ObjC'}
  
  s.public_header_files = "XAnimation/Classes/PublicHeaders/*.h","XAnimation/Classes/XAimationExtends/PublicHeaders/*.h"
  #如果需要暴露头文件，请保留umbrella.h,头文件不给值默认所有头文件为public

  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

