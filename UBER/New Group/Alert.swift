//
//  Alert.swift
//  UBER
//
//  Created by ITLabAdmin on 10/21/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import KRProgressHUD
extension UIViewController{
    func showErrorAlert(message: String) {
        //HUD.hide()
        KRProgressHUD.dismiss()
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showSuccessAlert(message: String) {
        KRProgressHUD.dismiss()
        let alertController = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
class Alert {
    static let shared = Alert()
}
