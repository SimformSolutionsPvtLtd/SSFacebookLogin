//
//  ViewController.swift
//  ReuseabelLogInComponets
//
//  Created by Sumit Goswami on 08/03/18.
//  Copyright © 2018 Simform Solutions PVT. LTD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

