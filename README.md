# Napp Notifications Fastlane Plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-napp_notifications)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-napp_notifications`, add it to your project by running:

```bash
fastlane add_plugin napp_notifications
```

## About

Napp Notifications is a Push Notification service for Mobile apps. This plugin automates the creation of apps and keeping certificates. 

## Example

```ruby
napp_notifications(
    admin_api_key: "Napp Notifications API-KEY",
    app_id: "Napp Notifications App Id",
    bundle_id: "com.example.helloworld",
    cert_p12: "Path to Apple .p12 file",
    cert_password: "Password for .p12 file",
    base_url: "URL to server (optional)"
)

```
## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
