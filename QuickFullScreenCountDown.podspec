Pod::Spec.new do |s|
    s.name             = "QuickFullScreenCountDown"
    s.version          = "1.0.0"
    s.summary          = "A full screen count down view for iOS. 一款全屏倒计时视图，须在Info.plist中增加后台模式支持。"
    s.description      = <<-DESC
    A full screen count down view for iOS. 一款全屏倒计时视图，须在Info.plist中增加后台模式支持, 常见于运动类App中。
    DESC
    s.homepage         = "https://github.com/pcjbird/QuickFullScreenCountDown"
    s.license          = 'MIT'
    s.author           = {"pcjbird" => "pcjbird@hotmail.com"}
    s.source           = {:git => "https://github.com/pcjbird/QuickFullScreenCountDown.git", :tag => s.version.to_s}
    s.social_media_url = 'http://www.lessney.com'
    s.requires_arc     = true
    #s.documentation_url = 'https://github.com/pcjbird/QuickFullScreenCountDown/blob/master/README.md'
    #s.screenshot       = 'https://github.com/pcjbird/QuickFullScreenCountDown/logo.png'

    s.platform         = :ios, '8.0'
    s.frameworks       = 'Foundation', 'UIKit', 'CoreGraphics', 'AVFoundation'
    #s.preserve_paths   = ''
    s.source_files     = 'QuickFullScreenCountDown/*.{h,m}'
    s.public_header_files = 'QuickFullScreenCountDown/*.{h}'


    s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }

end

