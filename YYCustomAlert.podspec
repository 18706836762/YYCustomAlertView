
Pod::Spec.new do |spec|
  spec.name         = 'YYCustomAlert'
  spec.version      = '1.1.0'
  spec.license      = 'MIT'
  spec.summary      = 'YYCustomAlert is a test'
  spec.homepage     = 'https://github.com/18706836762/YYCustomAlertView'
  spec.author       = {"wangyuanyuan"=>"624473068@qq.com"}
  spec.source       = { :git => 'https://github.com/18706836762/YYCustomAlertView.git', :tag => '1.1.0' }
  spec.platform     = :ios, '9.0'
  spec.source_files = 'YYCustomAlert/*'
  spec.requires_arc = true
end
