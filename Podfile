# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

def shared_pods
	pod 'EVReflection', '~> 2.9'
end

target 'ComputerAvailCheck' do
    platform :ios, '9.0'
    pod 'SOAPEngine', '~> 1.24'
    pod 'AMScrollingNavbar', '~> 2.0'
	pod 'iRate', '~> 1.11.6'
	pod 'Siren', '~> 0.9.5'
	shared_pods
end

target 'WatchCheck' do
    
end

target 'WatchCheck Extension' do
    platform :watchos, '2.0'
    shared_pods
end
