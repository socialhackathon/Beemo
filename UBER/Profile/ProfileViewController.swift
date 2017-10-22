//
//  ProfileViewController.swift
//  UBER
//
//  Created by ZYFAR on 21.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cardLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Профиль"
    }

    
    @IBAction func changePasswordButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangingPasswordViewController") as! ChangingPasswordViewController
        self.navigationController?.show(vc, sender: self)
    }
    @IBAction func logoutButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Login")
        present(vc, animated: true, completion: nil)
    }
}
