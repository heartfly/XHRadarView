#
# Be sure to run `pod lib lint XHRadarView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "XHRadarView"
  s.version          = "0.5.0"
  s.summary          = "A short description of XHRadarView."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/imqxh/XHRadarView.git"
  s.license          = 'MIT'
  s.author           = { "邱星豪" => "qiuxh@2345.com" }
  s.source           = { :git => "https://github.com/imqxh/XHRadarView.git" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'XHRadarView/*'

  s.public_header_files = 'XHRadarView/*.h'
end
