# Branvier Template

## Installation

1. Clone the repository
2. Run flutter create .

## Useful Links

### [Firebase Exceptions](https://github.com/Isagani-lapira/FirebaseAuth_ErrorCode)
### [Mac Configuration](https://github.com/iransneto/my-setup/blob/main/README.md)
### [Web - CORS for Firebase Storage](https://stackoverflow.com/questions/65849071/flutter-firebase-storage-cors-issue):
https://console.cloud.google.com/welcome?project=satiro-84d18 & open dashboard/cloud shell terminal.

> echo '[{"origin": ["*"],"responseHeader": ["Content-Type"],"method": ["GET", "HEAD"],"maxAgeSeconds": 3600}]' > cors-config.json

> gsutil cors set cors-config.json gs://biart-3a359.appspot.com

## Firebase Functions
Existem duas formas de usar endpoints no Functions.
> onRequest: Para endpoints que possam ser usados por qualquer cliente.
> onCall: Para endpoints que só podem ser usados pelo cloud_functions do Flutter.

No onRequest, você usaria o dio, por exemplo, para fazer a requisição.
No onCall, você usaria o cloud_functions do Flutter.

Obs: onRequest não tem segurança, precisa configurar CORS e headers manualmente.
Obs2: onCall precisa de autenticação do GCP:
https://console.cloud.google.com/run?project=omnistay-6bd31
> select > Permissions > Add Principal > allUsers > Role > Cloud Run Invoker > Save

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