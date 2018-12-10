Pod::Spec.new do |s|

  s.name         = "BLAlert"
  s.version      = "0.0.1"
  s.summary      = "iOS custom alert controller, you can DIY 🔨."
  s.homepage     = "https://github.com/bolee/BLAlert"
  s.license      = "MIT"
  s.author       = { "bolee" => "cn.bobolee.org@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/bolee/BLAlert.git", :tag => s.version}
  s.source_files = "BLALert/*.{h,m}"
  s.requires_arc = true

end
