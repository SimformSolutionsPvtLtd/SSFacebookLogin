Pod::Spec.new do |s|
  s.name             = 'SSFacebookLogin'
  s.version          = '2.0.0'
  s.summary          = 'The Reusable Facebook Login Components for iOS is the easiest way to get data from Facebook.'
 
  s.description      = 'The Reusable Facebook Login Components for iOS is the easiest way to get data from Facebook.'
 
  s.homepage         = 'https://github.com/simformsolutions/SSFacebookLogin.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sanjaysinh Chauhan' => 'sanjaysinh.C@simformsolutions.com' }
  s.source           = { :git => 'https://github.com/simformsolutions/SSFacebookLogin.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'ReuseabelLogInComponets/Classes/*.swift'

    s.dependency 'FBSDKLoginKit', '4.30.0'

  
end
