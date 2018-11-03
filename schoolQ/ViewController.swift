//
//  ViewController.swift
//  schoolQ
//
//  Created by Mitchell Markoff on 10/5/18.
//  Copyright © 2018 Mitchell Markoff. All rights reserved.
//

import UIKit
import FirebaseUI
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginTapped(_ sender: Any) {
        
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            return
        }
        authUI?.delegate = self
        
        let authViewController = authUI!.authViewController()
        
        present(authViewController, animated: true, completion: nil)
    }
    
}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error != nil else {
            performSegue(withIdentifier: "home", sender: self)
            return
        }
        //authDataResult?.user.uid
        
    }
}


