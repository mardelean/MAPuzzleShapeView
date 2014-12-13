Pod::Spec.new do |spec|
  spec.name         = 'MAPuzzleShapeView'
  spec.version      = '0.0.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/MadalinaArdelean/MAPuzzleShapeView'
  spec.authors      = { 'Madalina Ardelean' => 'ardeleanmada1@gmail.com' }
  spec.summary      = 'A rectangular view with puzzle shapes drawn on different sides.'
  spec.source       = { :git => 'https://github.com/MadalinaArdelean/MAPuzzleShapeView.git', :tag => "#{spec.version}" }
  spec.source_files = 'MAPuzzleShapeView/Classes/GUI/MAPuzzleShapeView/*.{h,m}'
  spec.framework    = 'UIKit'
  spec.platform     = :ios, '7.0'
  spec.requires_arc = true
end