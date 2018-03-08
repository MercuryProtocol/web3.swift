platform :ios, '9.0'

def testing_pods
  pod 'Geth', '1.8.2'
  pod 'CryptoSwift'
end


target 'web3swift' do
  use_frameworks!
  # Pods for web3swift
  testing_pods

  target 'web3swiftTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

#target 'iOS Example' do
#  project 'Example/iOS Example'

#  testing_pods
#end