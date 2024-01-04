# Reusable Facebook Login Components


The Reusable Facebook Login Components for iOS is the easiest way to get user data from Facebook .


## Features

- [x] Get Default data of user from facebook
- [x] Get Specific data of user from facebook

## Requirements

- iOS 8.0+
- Xcode 7.3+

## Installation

### CocoaPods

To incorporate the **SSFacebookLogin** library into your Xcode project utilizing CocoaPods, please reference it within your `Podfile` as shown below:

```ruby
pod 'SSFacebookLogin'
```
### Swift Package Manager

To add **SSFacebookLogin** as a dependency to your project, follow these steps:

1. Open your Swift project in Xcode.
2. Navigate to `File` -> `Add Package Dependencies...`.
3. Paste `https://github.com/SimformSolutionsPvtLtd/SSFacebookLogin.git` into the search bar.
4. Choose the version you want to use and click `Add Package`.

### Manually 

If you prefer not to use any of the dependency managers above, you can integrate **SSFacebookLogin** into your project manually. 
- Just copy  `LoginManager.swift`, `FaceBookConstant.swift` and `userData.swift` from the `Classes` folder into your Xcode project.
- Make sure to add Facebook SDK or Pod's for iOS.

## Migration Guide
- For minimum `iOS 11.0` use `6.0.4`
- For minimum `iOS 12.0` or above use `7.0.0`

## Configure App
1. Right-click `Info.plist`, and choose **Open As ▸ Source Code**.
2. Copy and paste the following XML snippet into the body of your file (`<dict>...</dict>`)
    ```
    <key>CFBundleURLTypes</key>
    <array>
      <dict>
      <key>CFBundleURLSchemes</key>
      <array>
        <string>fbAPP-ID</string>
      </array>
      </dict>
    </array>
    <key>FacebookAppID</key>
    <string>APP-ID</string>
    <key>FacebookClientToken</key>
    <string>CLIENT-TOKEN</string>
    <key>FacebookDisplayName</key>
    <string>APP-NAME</string>
    ```
- In `CFBundleURLSchemes`, replace APP-ID with your App ID.
- In `FacebookAppID`, replace APP-ID with your App ID.
- In `FacebookClientToken`, replace CLIENT-TOKEN with the value found under Settings > Advanced > Client Token in your Facebook App Dashboard.
- In `FacebookDisplayName`, replace APP-NAME with the name of your app.
3. Add following code blocks in `AppDelegate.swift` file
    - In **didFinishLaunchingWithOptions** method,
    ```swift
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Add below line for facebook configuration
            LoginManager.shared.facebookConfiguration(application, didFinishLaunchingWithOptions: launchOptions)
            return true
        }
    ```
    - In **openUrlWithOption** method,
    ```swift
        func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            return LoginManager.shared.faceboolUrlConfigurationWithOptions(app, open: url, options: options)
        }
    ```
4. Voila 🪄✨💫 !
- For more details => [Facebook Integration for iOS](https://developers.facebook.com/docs/facebook-login/ios)

## Usage example

##### Example 1 (Get default data of user when no any arguments passed)

```swift
    LoginManager.shared.loginWithFacebook(controller: self, { (token, error) in
    
    if error == nil {
        print(token?.userID ?? "",token?.tokenString ?? "")
    }
    
    }) { (result, error) in
    
        if error == nil {
            if let userData = result as? UserData {
                print(userData)
                print(userData.id)
            } else {
                print(result ?? "")
            }
        }
    }
```

##### Example 2 (Get specific data of user by passing argument)

```swift

    LoginManager.shared.loginWithFacebook(permission: [.email, .publicProfile, .userBirthday],
    requriedFields: [.birthday, .about, .email], controller: self, { (token, error) in
    
    if error == nil {
        print(token?.userID ?? "",token?.tokenString ?? "")
    }
    
    }) { (result, error) in

        if error == nil {
            if let uResult = result  {
                print(uResult)
            }
        }
    }

```
## 🤝 How to Contribute

Whether you're helping us fix bugs, improve the docs, or a feature request, we'd love to have you! :muscle:

Check out our [**Contributing Guide**](CONTRIBUTING.md) for ideas on contributing.

## Find this library useful? ❤️

Give a ⭐️ if this project helped you!

## Check out our other Libraries

<h3><a href="https://github.com/SimformSolutionsPvtLtd/Awesome-Mobile-Libraries"><u>🗂 Simform Solutions Libraries→</u></a></h3>

## MIT License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
