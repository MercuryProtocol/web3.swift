![web3swift: Elegant Blockchaining in Swift](https://raw.githubusercontent.com/web3swift/web3swift/master/web3swift.png)

[![Build Status](https://travis-ci.org/web3swift/web3swift.svg?branch=master)](https://travis-ci.org/web3swift/web3swift)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/web3swift.svg)](https://img.shields.io/cocoapods/v/web3swift.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/web3swift.svg?style=flat)](https://web3swift.github.io/web3swift)
[![Twitter](https://img.shields.io/badge/twitter-@web3swiftSF-blue.svg?style=flat)](http://twitter.com/web3swiftSF)
[![Gitter](https://badges.gitter.im/web3swift/web3swift.svg)](https://gitter.im/web3swift/web3swift?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

web3swift is a library written in Swift.

- [Features](#features)
- [Component Libraries](#component-libraries)
- [Requirements](#requirements)
- [Migration Guides](#migration-guides)
- [Communication](#communication)
- [Installation](#installation)
- [Usage](Documentation/Usage.md)
    - **Intro -** [Making a Request](Documentation/Usage.md#making-a-request), [Encoding](Documentation/Usage.md#encoding), [Response Validation](Documentation/Usage.md#response-validation), [Response Caching](Documentation/Usage.md#response-caching)
- [Advanced Usage](Documentation/AdvancedUsage.md)
	- **Account Creation -** [Signing](Documentation/AdvancedUsage.md#session-manager), [Signing](Documentation/AdvancedUsage.md#session-delegate)
	- **Signing -** [Signing](Documentation/AdvancedUsage.md#routing-requests)
- [FAQ](#faq)
- [Credits](#credits)
- [License](#license)

## Features

- [x] Create Account
- [x] Import Account
- [x] Create and Encode Transaction
- [x] Sign Transaction
- [x] [Complete Documentation](https://web3swift.github.io/web3swift)

## Component Libraries

In order to keep web3swift focused specifically on core networking implementations, additional component libraries have been created by the [web3swift Software Foundation](https://github.com/web3swift/Foundation) to bring additional functionality to the web3swift ecosystem.

- [web3swiftImage](https://github.com/web3swift/web3swiftImage) - An image library including image response serializers, `UIImage` and `UIImageView` extensions, custom image filters, an auto-purging in-memory cache and a priority-based image downloading system.
- [web3swiftNetworkActivityIndicator](https://github.com/web3swift/web3swiftNetworkActivityIndicator) - Controls the visibility of the network activity indicator on iOS using web3swift. It contains configurable delay timers to help mitigate flicker and can support `URLSession` instances not managed by web3swift.

## Requirements

- iOS 9.0+
- Xcode 9.2+
- Swift 4.0.0+

## Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/web3swift). (Tag 'web3swift')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/web3swift).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1+ is required to build web3swift 4.0+.

To integrate web3swift into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'web3swift', '~> 0.0.6'
end
```

Then, run the following command:

```bash
$ pod install
```


## FAQ

### What's web3swift?

web3swift is

## Credits

web3swift is owned and maintained by the [Radical App LLC](http://www.mercuryprotocol.com). You can follow them on Twitter at [@MercuryProtocol](https://twitter.com/mercuryprotocol) for project updates and releases.

### Security Disclosure

If you believe you have identified a security vulnerability with web3swift, you should report it as soon as possible via email to security@mercuryprotocol.com. Please do not post it to a public issue tracker.

## License

web3swift is released under the MIT license. [See LICENSE](https://github.com/web3swift/web3swift/blob/master/LICENSE) for details.
