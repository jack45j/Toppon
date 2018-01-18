Pod::Spec.new do |s|
  s.name         = ‘Toppon’
  s.version      = '0.0.1'
  s.summary      = ‘A simple scroll-to button for iOS UIScrollView’
  s.homepage     = 'https://github.com/jack45j/Toppon’
  s.license      = 'MIT'
  s.authors = { ‘Benson Lin’ => ‘Benson@ycstudio.com.tw’ }
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/jack45j/Toppon.git', :tag => s.version.to_s }
  s.source_files  = ‘Toppon/sources/*.swift'
  s.requires_arc = true
end
