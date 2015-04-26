#
# Be sure to run `pod lib lint BAHYouTubeOAuth.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BAHYouTubeOAuth"
  s.version          = "0.1.1"
  s.summary          = "Simple YouTube OAuth 2.0 Client"
  s.description      = <<-DESC
                       A very simply, easy to use, specific to YouTube OAuth 2.0 client

                       DESC
  s.homepage         = "https://github.com/BHughes3388/BAHYouTubeOAuth"
  s.screenshots     = "http://img.photobucket.com/albums/v235/rx7anator/Mobile%20Applications/342fcd25-dcb1-4c74-80a4-1665d0e97d68_zpsqxklg9jn.png"
  s.license          = 'MIT'
  s.author           = { "BHughes3388" => "BHughes3388@gmail.com" }
  s.source           = { :git => "https://github.com/BHughes3388/BAHYouTubeOAuth.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'BAHYouTubeOAuth' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
