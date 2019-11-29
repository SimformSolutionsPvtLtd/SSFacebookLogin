# Reusable Facebook Login Components


The Reusable Facebook Login Components  for iOS is the easiest way to get data  from Facebook .


## Features

- [x] Get default user data from facebook
- [x] Get Specific user data from facebook

## Requirements

- iOS 8.0+
- Xcode 7.3

## Installation

#### Take LoginManager.swift,FaceBookConstant.swift and userData.Swift
Import two files in your project and it's done

#### Manually
1. Configure Facebook App Settings for iOS (https://developers.facebook.com/docs/facebook-login/ios)
2. Download Facebook SDK Or Pod's for iOS
3. Add SDK to Project
4. Configure Xcode Project
5. Connect App Delegate Using LoginManager.swift Methods
6. Congratulations!

## Migration Guide
- Developer must Use version 6.0.3 or lower for support of iOS 10.0.
- Developer must Use version 6.0.4 or lower for support of iOS 11.0.
- For minimum iOS target 11.0 use 6.0.4.
- For minimum iOS target 12.0 use 6.0.6.

## Usage example
##### Developer must have to call function from appdelegate didFinishlaunching.

```swift
    LoginManager.shared.facebookConfiguration(application, didFinishLaunchingWithOptions: launchOptions)
```

##### Developer must have to implement open url method in appdelegate file.

```swift

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation:
    Any) -> Bool {
        return  LoginManager.shared.facebookUrlConfiguration(application, open: url,
        sourceApplication:
        sourceApplication, annotation: annotation)
    }
```

##### Example 1(you can get default data when not passing any argument)

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

##### example 2 (get your specific user data with passing argument)

```swift

    LoginManager.shared.loginWithFacebook(permission: [.email,.publicProfile,.userBirthday],
    requriedFields: [.birthday,.about,.email], controller: self, { (token, error) in
    
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
