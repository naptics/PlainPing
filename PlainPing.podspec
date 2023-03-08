
Pod::Spec.new do |s|
  s.name             = "PlainPing"
  s.version          = "0.5.2"
  s.summary          = "a very plain ping interface in swift"

  # s.description      = <<-DESC
  #                       Ping from your iOS App
  #                      DESC

  s.homepage         = "https://github.com/naptics/PlainPing"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Jonas Schoch" => "jonas.schoch@naptics.ch" }
  s.source           = { :git => "https://github.com/naptics/PlainPing.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/naptics'

  s.platforms    = { :ios => "8.0", :osx => "10.11" }
  s.requires_arc = true
  
  s.xcconfig = { 'SWIFT_INSTALL_OBJC_HEADER' => 'NO' }

  s.source_files = 'Sources/PlainPing/*', 'Sources/SimplePing/include/*', 'Sources/SimplePing/*'

  #s.resource_bundles = {
  #  'PlainPing' => ['Pod/Assets/*.png']
  #}
end
