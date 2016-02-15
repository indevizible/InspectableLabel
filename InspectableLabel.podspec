Pod::Spec.new do |s|
s.name					= "InspectableLabel"
s.version				= "1.0.0"
s.summary				= "InspectableLabel is inspectable and designable label that easy to use."
s.homepage				= "https://github.com/indevizible/InspectableLabel"
s.license				= { :type => "Apache 2.0", :file => 'LICENSE' }
s.authors				= { "Nattawut Singhchai" => "jadedragon17650@gmail.com" }

s.ios.deployment_target	= "8.0"
s.source				= { :git => "https://github.com/indevizible/InspectableLabel.git", :tag => "#{s.version}"}
s.source_files 		 	= "InspectableLabelExample/InspectableLabel.swift"
s.requires_arc			= true
end