platform :ios, '9.0'

def testing_pods
  pod 'Geth', '1.7.3'
  pod 'CryptoSwift'
  pod 'BigInt', '~> 3.0'
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