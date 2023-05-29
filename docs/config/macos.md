# Configuring entitlements for a Flutter macOS project

## Introduction

Entitlements are a set of privileges and permissions that your app requests from the operating system. Entitlements determine what your app can and cannot do on the device, including accessing sensitive data, using hardware resources, and communicating with other apps and servers.

This guide will walk you through the steps to configure entitlements in your Flutter macOS project, including editing your entitlements file and configuring your Xcode project.

## Steps

1. Open your entitlements file: Open your entitlements file (e.g. `macos/Runner/DebugProfile.entitlements`) in a text editor. You can also create a new entitlements file by running the `flutter create macos` command.

2. Add or modify an entitlement: To add a new entitlement or modify an existing one, add the entitlement key and value to your entitlements file. Make sure that the value of the entitlement matches the value in your provisioning profile and Xcode project settings. Here's an example of an entitlements file that includes the `com.apple.security.app-sandbox` and `keychain-access-groups` entitlements:

    ```entitlements
    <key>keychain-access-groups</key>
    <array>
        <string>$(AppIdentifierPrefix)$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    </array>
    ```

    ```entitlements
    <dict>
        <key>com.apple.security.app-sandbox</key>
        <true/>
        <key>com.apple.security.cs.allow-jit</key>
        <true/>
        <key>com.apple.security.network.server</key>
        <true/>
        <key>com.apple.security.network.client</key> // <--- for dio
        <true/>
        <key>keychain-access-groups</key> // <--- for flutter_secure_storage
        <array>
            <string>5CFRR4VL25.com.branvier.branvierTemplate</string> 
        </array>
    </dict>
    ```

3. Configure provisioning profiles: Download and install the appropriate provisioning profiles for your app. Make sure that the provisioning profiles match the entitlements in your entitlements file.

    1. Right click macos folder and select `Open in Xcode`
    2. Go to Runner > Targets > Runner > Singing & Capbilities
    3. Add a Team or configure and check the `AppIdentifierPrefix` and `PRODUCT_BUNDLE_IDENTIFIER`
    4. For checking the identifier, open the Team, select `add an account`
    5. Select the team and tap `Download Manual Profiles`.
    6. On Finder, `Go to folder...`: `/Users/art/Library/MobileDevice/Provisioning Profiles`
    7. Double click the last generated profile and get your identifier.

> Done! Verify your configuration: Run your app in Xcode and verify that `flutter_secure_storage` or `dio` are able to store and retrieve data from secure storage or api rest server.
