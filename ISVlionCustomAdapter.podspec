Pod::Spec.new do |s|
    s.name             = 'ISVlionCustomAdapter'
    s.version          = '1.0.03'
    s.summary          = 'ISVlionCustomAdapter.podspec.'
    s.description      = 'This is the ISVlionCustomAdapter.podspec. Please proceed to https://www.mentamob.com for more information.'
    s.homepage         = 'https://github.com/mentasdk/global_ironsource_adapter.git'
    s.license          = "Custom"
    s.author           = { 'mentasdk' => 'mentasdk.vip@gmail.com' }
    s.source           = { :git => "https://github.com/mentasdk/global_ironsource_adapter.git", :tag => "#{s.version}" }
  
    s.ios.deployment_target = '13.0'
    s.frameworks = 'JavaScriptCore', 'WebKit', 'AdSupport', 'SystemConfiguration'
    s.libraries = 'z', 'sqlite3.0'
    s.weak_frameworks = 'WebKit', 'AdSupport'
    s.static_framework = true
  
    s.source_files = 'ISVlionCustomAdapter/**/*'

    s.dependency 'MentaBaseGlobal',         '~> 1.0.25'
    s.dependency 'MentaMediationGlobal',    '~> 1.0.25'
    s.dependency 'MentaVlionGlobal',        '~> 1.0.25'
    s.dependency 'MentaVlionGlobalAdapter', '~> 1.0.25'
    s.dependency 'IronSourceSDK'
  
  end
