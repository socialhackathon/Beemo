//
//  LoginViewController.swift
//  UBER
//
//  Created by ZYFAR on 21.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Вход"
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @IBAction func showRegistration(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showMain(_ sender: UIButton) {
        let login = loginTextField.text
        
        let password = passwordTextField.text
        
        if login != "" && password != "" {

            ServerManager.shared.login(login: login!, password: password!, completion: log_in, error: showErrorAlert)
        }
        else {
            showErrorAlert(message: "Заполните поля!")
        }
    }
    
    func log_in() {
        //HUD.hide()
        DataManager.shared.saveUser(username: loginTextField.text!, password: passwordTextField.text!)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Main")
        present(vc, animated: true, completion: nil)
    }
}
