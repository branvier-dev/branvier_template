# Branvier Template

## Installation

1. Clone the repository
2. Run flutter create .

## Useful Links

[Firebase Exceptions](https://github.com/Isagani-lapira/FirebaseAuth_ErrorCode)
[Mac Configuration](https://github.com/iransneto/my-setup/blob/main/README.md)
[Web - CORS for Firebase Storage](https://stackoverflow.com/questions/65849071/flutter-firebase-storage-cors-issue)

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

# MacOS Podfile Fix
```ruby
post_install do |installer|
  # Ensure pods also use the minimum deployment target set above
  # https://stackoverflow.com/a/64385584/436422
  puts 'Determining pod project minimum deployment target'

  pods_project = installer.pods_project
  deployment_target_key = 'MACOSX_DEPLOYMENT_TARGET'
  deployment_targets = pods_project.build_configurations.map{ |config| config.build_settings[deployment_target_key] }
  minimum_deployment_target = deployment_targets.min_by{ |version| Gem::Version.new(version) }

  puts 'Minimal deployment target is ' + minimum_deployment_target
  puts 'Setting each pod deployment target to ' + minimum_deployment_target

  installer.pods_project.targets.each do |target|
    flutter_additional_macos_build_settings(target)
    if target.name == 'BoringSSL-GRPC'
      target.source_build_phase.files.each do |file|
        if file.settings && file.settings['COMPILER_FLAGS']
          flags = file.settings['COMPILER_FLAGS'].split
          flags.reject! { |flag| flag == '-GCC_WARN_INHIBIT_ALL_WARNINGS' }
          file.settings['COMPILER_FLAGS'] = flags.join(' ')
        end
      end
    end
    target.build_configurations.each do |config|
      config.build_settings[deployment_target_key] = minimum_deployment_target
    end
  end
end
```