Pod::Spec.new do |s|
  s.name         = "web3swift"
  s.version      = "0.0.6"
  s.summary      = "A short description of web3swift."
  s.description  = <<-DESC
                        web3swift is a library currently only built for iOS platform. It's built on top of the [go-ethereum](https://github.com/ethereum/go-ethereum). This allows you to work with the Ethereum blockchain, without the additional overhead of having to write your own integration code for the platform.

                   DESC
  s.homepage     = "http://www.mercuryprotocol.com/web3swift"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors            = { "Sameer Khavanekar" => "sameer@mercuryprotocol.com", "Rohit Kotian" => "rohit@mercuryprotocol.com" }
  s.social_media_url   = "https://twitter.com/mercuryprotocol"

  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://git.cyberdust.com/sameer/web3swift.git", :tag => "#{s.version}", :submodules => true  }

  s.source_files = "Source/**/*.{h,swift}"
  # s.public_header_files = 'Sources/*.h'
  s.requires_arc = true

  s.static_framework = true
  s.dependency "CryptoSwift"
  s.dependency 'Geth'
  s.pod_target_xcconfig = {
     "ENABLE_BITCODE" => 'NO'
  }

end
