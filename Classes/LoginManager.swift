//
//  LoginManager.swift
//  ReuseabelLogInComponets
//
//  Created by Sumit Goswami on 09/03/18.
//  Copyright © 2018 Simform Solutions PVT. LTD. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import CryptoKit

public class LoginManager: NSObject {
    
    public static let shared = LoginManager()
    
    let facebookManger = FBSDKLoginKit.LoginManager()
    
    public func facebookConfiguration(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)  {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    public func faceboolUrlConfigurationWithOptions(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url , options: options)
    }
    
    public func loginWithFacebook(permission:[ReadPermissions]? = nil,requriedFields:[NeededFields]? = nil,controller:UIViewController,_ loginCompletion:@escaping (AccessToken?, NSError?)->(),_ userDatacompletion:@escaping(AnyObject?, NSError?)->Void)  {
        
        facebookManger.logIn(permissions: getReadPermission(readPermission: permission), from: controller) { (result, error) in
            if let unwrappedError = error {
                self.facebookManger.logOut()
                loginCompletion(nil,unwrappedError as NSError?)
            } else if (result?.isCancelled)! {
                self.facebookManger.logOut()
                loginCompletion(nil,nil)
            } else {
                guard let uResult = result else {
                    loginCompletion(nil,Error.facebookNoResult)
                    return
                }
                if uResult.declinedPermissions.count == 0 {
                    if let _ = uResult.token?.tokenString {
                        GraphRequest.init(graphPath: "me", parameters:["fields":self.getNeededFields(requiredPermission: requriedFields)] ).start(completion: { (connection, response, meError) in
                            if let unwrappedMeError = meError {
                                userDatacompletion(nil,unwrappedMeError as NSError?)
                            }else{
                                if requriedFields == nil {
                                  userDatacompletion(self.parseUserData(dataResponse: response as AnyObject),nil)
                                  return
                                }
                                userDatacompletion(response as AnyObject?,nil)
                            }
                        })
                    }
                    loginCompletion(uResult.token, nil)
                } else {
                    self.showPopUp(viewController: controller)
                    loginCompletion(uResult.token, nil)
                }
            }
        }
    }
    
    public func logInWithFacebookFirebase(permission:[ReadPermissions]? = nil, requriedFields:[NeededFields]? = nil, tracking: LoginTracking, controller:UIViewController,_ loginCompletion: @escaping (String?, String? ,NSError?)->(),_ userDatacompletion: @escaping(AnyObject?, NSError?)->Void) {
        let nonce = randomNonceString()
        facebookManger.logIn(
            viewController: controller,
            configuration: LoginConfiguration(permissions: getReadPermission(readPermission: permission), tracking: tracking, nonce: sha256(nonce))
        ) { result in
            switch result {
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                if declinedPermissions.isEmpty {
                    if let tokenString = AuthenticationToken.current?.tokenString {
                        loginCompletion(AuthenticationToken.current?.tokenString,nonce, nil)
                        userDatacompletion(Profile.current as AnyObject?, nil)
                    }
                } else {
                    self.showPopUp(viewController: controller)
                    loginCompletion(AuthenticationToken.current?.tokenString, nonce, nil)
                }
                
            case .failed(let error):
                self.facebookManger.logOut()
                loginCompletion(nil, nil, error as NSError?)
                
            case .cancelled:
                self.facebookManger.logOut()
                loginCompletion(nil, nil, nil)
            }
        }
    }
    
    public func logIn(permission:[ReadPermissions]? = nil, requriedFields:[NeededFields]? = nil, tracking: LoginTracking, controller:UIViewController,_ loginCompletion: @escaping (String? ,NSError?)->(),_ userDatacompletion: @escaping(AnyObject?, NSError?)->Void) {
        
        facebookManger.logIn(
            viewController: controller,
            configuration: LoginConfiguration(permissions: getReadPermission(readPermission: permission), tracking: tracking)
        ) { result in
            switch result {
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                if declinedPermissions.isEmpty {
                    if let tokenString = AuthenticationToken.current?.tokenString {
                        loginCompletion(AuthenticationToken.current?.tokenString, nil)
                        userDatacompletion(Profile.current as AnyObject?, nil)
                    }
                } else {
                    self.showPopUp(viewController: controller)
                    loginCompletion(AuthenticationToken.current?.tokenString, nil)
                }
                
            case .failed(let error):
                self.facebookManger.logOut()
                loginCompletion(nil, error as NSError?)
                
            case .cancelled:
                self.facebookManger.logOut()
                loginCompletion(nil, nil)
            }
        }
    }
    
    private func getReadPermission(readPermission:[ReadPermissions]?) -> [String] {
        var permissionString:[String] = [String]()
        if readPermission == nil {
           return FacebookConstante.readPermissions
        } else {
            for value in readPermission! {
                permissionString.append(value.rawValue)
            }
        }
        return permissionString
    }
    
    
    private func getNeededFields(requiredPermission:[NeededFields]?) -> String {
        var permissionString:String = ""
        if requiredPermission == nil {
            return FacebookConstante.neededFields
        } else {
            for value in requiredPermission! {
                permissionString.append(value.rawValue)
                if value.rawValue != requiredPermission?.last?.rawValue {
                    permissionString.append(",")
                }
            }
        }
        return permissionString
    }
    
    private func showPopUp(viewController:UIViewController) {
        let alert = UIAlertController(title: "Permissions Declined", message: "please give all permissions needed to sigup user", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    private func parseUserData(dataResponse:AnyObject) -> UserData {
        let userData = UserData()
        
        if let about = dataResponse.object(forKey: NeededFields.about.rawValue) as? String {
           userData.about = about
        }
        if let birthday = dataResponse.object(forKey: NeededFields.birthday.rawValue) as? String {
           userData.birthday = birthday
        }
        if let email = dataResponse.object(forKey: NeededFields.email.rawValue) as? String {
           userData.email = email
        }
        if let firstName = dataResponse.object(forKey: NeededFields.firstName.rawValue) as? String {
           userData.firstName = firstName
        }
        if let lastName = dataResponse.object(forKey: NeededFields.lastName.rawValue) as? String {
           userData.lastName = lastName
        }
        if let gender = dataResponse.object(forKey: NeededFields.gender.rawValue) as? String {
           userData.gender = gender
        }
        if let name = dataResponse.object(forKey: NeededFields.name.rawValue) as? String {
           userData.name = name
        }
        if let id = dataResponse.object(forKey: NeededFields.id.rawValue) as? String {
           userData.id = id
        }
        if let picture = dataResponse.object(forKey: NeededFields.picture.rawValue) as? NSDictionary {
            
            if let data = picture.value(forKey: "data") as? NSDictionary {
                
                userData.photoUrl = data.value(forKey:"url") as! String
                
            }
        }

        return userData
    }
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }

            
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }

    
}


