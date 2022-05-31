//
//  ViewController.swift
//  On The Map
//
//  Created by David Hsieh on 8/3/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        APIClient.login(username: emailTextField.text!, password: passwordTextField.text!, completion: handleSessionResponse(success:error:))
    }
    
    func handleSessionResponse(success: Bool, error: Error?) {
        if (success) {
            APIClient.userId = self.emailTextField.text!
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            self.showFailureMessage(message: error?.localizedDescription ?? "")
        }
    }
}

