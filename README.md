![EtherS: Elegant Blockchaining in Swift](https://raw.githubusercontent.com/EtherS/EtherS/master/EtherS.png)

[![Build Status](https://travis-ci.org/EtherS/EtherS.svg?branch=master)](https://travis-ci.org/EtherS/EtherS)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/EtherS.svg)](https://img.shields.io/cocoapods/v/EtherS.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/EtherS.svg?style=flat)](https://EtherS.github.io/EtherS)
[![Twitter](https://img.shields.io/badge/twitter-@EtherSSF-blue.svg?style=flat)](http://twitter.com/EtherSSF)
[![Gitter](https://badges.gitter.im/EtherS/EtherS.svg)](https://gitter.im/EtherS/EtherS?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

EtherS is an HTTP networking library written in Swift.

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

- [x] Chainable Request / Response Methods
- [x] URL / JSON / plist Parameter Encoding
- [x] Upload File / Data / Stream / MultipartFormData
- [x] Download File using Request or Resume Data
- [x] Authentication with URLCredential
- [x] HTTP Response Validation
- [x] Upload and Download Progress Closures with Progress
- [x] cURL Command Output
- [x] Dynamically Adapt and Retry Requests
- [x] TLS Certificate and Public Key Pinning
- [x] Network Reachability
- [x] Comprehensive Unit and Integration Test Coverage
- [x] [Complete Documentation](https://EtherS.github.io/EtherS)

## Component Libraries

In order to keep EtherS focused specifically on core networking implementations, additional component libraries have been created by the [EtherS Software Foundation](https://github.com/EtherS/Foundation) to bring additional functionality to the EtherS ecosystem.

- [EtherSImage](https://github.com/EtherS/EtherSImage) - An image library including image response serializers, `UIImage` and `UIImageView` extensions, custom image filters, an auto-purging in-memory cache and a priority-based image downloading system.
- [EtherSNetworkActivityIndicator](https://github.com/EtherS/EtherSNetworkActivityIndicator) - Controls the visibility of the network activity indicator on iOS using EtherS. It contains configurable delay timers to help mitigate flicker and can support `URLSession` instances not managed by EtherS.

## Requirements

- iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8.3+
- Swift 3.1+

## Migration Guides

- [EtherS 4.0 Migration Guide](https://github.com/EtherS/EtherS/blob/master/Documentation/EtherS%204.0%20Migration%20Guide.md)
- [EtherS 3.0 Migration Guide](https://github.com/EtherS/EtherS/blob/master/Documentation/EtherS%203.0%20Migration%20Guide.md)
- [EtherS 2.0 Migration Guide](https://github.com/EtherS/EtherS/blob/master/Documentation/EtherS%202.0%20Migration%20Guide.md)

## Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/EtherS). (Tag 'EtherS')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/EtherS).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1+ is required to build EtherS 4.0+.

To integrate EtherS into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'EtherS', '~> 4.5'
end
```

Then, run the following command:

```bash
$ pod install
```

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate EtherS into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add EtherS as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/EtherS/EtherS.git
  ```

- Open the new `EtherS` folder, and drag the `EtherS.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `EtherS.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `EtherS.xcodeproj` folders each with two different versions of the `EtherS.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from, but it does matter whether you choose the top or bottom `EtherS.framework`.

- Select the top `EtherS.framework` for iOS and the bottom one for OS X.

    > You can verify which one you selected by inspecting the build log for your project. The build target for `EtherS` will be listed as either `EtherS iOS`, `EtherS macOS`, `EtherS tvOS` or `EtherS watchOS`.

- And that's it!

  > The `EtherS.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

## FAQ

### What's the origin of the name EtherS?

EtherS is named after

## Credits

EtherS is owned and maintained by the [Radical App LLC](http://www.mercuryprotocol.com). You can follow them on Twitter at [@MercuryProtocol](https://twitter.com/mercuryprotocol) for project updates and releases.

### Security Disclosure

If you believe you have identified a security vulnerability with EtherS, you should report it as soon as possible via email to security@mercuryprotocol.com. Please do not post it to a public issue tracker.

## License

EtherS is released under the MIT license. [See LICENSE](https://github.com/EtherS/EtherS/blob/master/LICENSE) for details.
