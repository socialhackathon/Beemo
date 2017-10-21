//
//  ProfileViewController.swift
//  UBER
//
//  Created by ZYFAR on 21.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Профиль"
    }

    @IBAction func logoutButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Login")
        present(vc, animated: true, completion: nil)
    }
}
