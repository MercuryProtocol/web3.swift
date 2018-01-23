workspace 'EtherS.xcworkspace'
platform :ios, '9.0'
use_frameworks!

def testing_pods
  pod 'Geth', '1.7.3'
  pod 'CryptoSwift'
end


target 'EtherS' do
  project 'EtherS'

  # Pods for EtherS
  testing_pods

  target 'EtherSTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'iOS Example' do
  project 'Example/iOS Example'

  testing_pods
end