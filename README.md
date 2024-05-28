# Branvier Template

## Installation

1. Clone the repository
2. Run flutter create .

## Useful Links

[Firebase Exceptions](https://github.com/Isagani-lapira/FirebaseAuth_ErrorCode)
[Mac Configuration](https://github.com/iransneto/my-setup/blob/main/README.md)

## MacOS Configuration

- DebugProfile.entitlements:

```entitlements
<dict>
 <key>com.apple.security.app-sandbox</key>
 <true/>
 <key>com.apple.security.cs.allow-jit</key>
 <true/>
 <key>com.apple.security.network.server</key>
 <true/>
 <!-- Required for client http. Ex:Dio -->
 <key>com.apple.security.network.client</key> 
 <true/>
 <!-- Required for pickers. Ex: ImagePicker -->
 <key>com.apple.security.files.user-selected.read-only</key>
   <true/>
</dict>
```
