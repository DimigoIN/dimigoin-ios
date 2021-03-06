fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios beta
```
fastlane ios beta
```
Push a new beta build to TestFlight
### ios versionBump
```
fastlane ios versionBump
```
Push a new beta build to TestFlight
### ios screenshots
```
fastlane ios screenshots
```
Generate new localized screenshots
### ios release
```
fastlane ios release
```
release - only build
### ios deploy
```
fastlane ios deploy
```
Deploy new build to AppStore

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
