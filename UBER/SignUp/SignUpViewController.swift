//
//  SignUpViewController.swift
//  UBER
//
//  Created by ZYFAR on 21.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordRepeatTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    let pickerView = UIPickerView()
    
    let sex = ["М" , "Ж"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = NSLocalizedString("Регистрация", comment: "Регистрация")
        setupPickerView()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        var newUser = Login()
        if phoneNumberTextField.text != "" && passwordTextField.text != "" && passwordRepeatTextField.text != "" && sexTextField.text != "" {
        
        if passwordTextField.text! != passwordRepeatTextField.text! {
            showErrorAlert(message: "Пароли не совпадают!")
        }
        else if passwordTextField.text!.count < 4 {
            showErrorAlert(message: "Пароль должен состоять из 4 и более символов!")
        }
        else if (phoneNumberTextField.text?.count)! < 10 {
            showErrorAlert(message: "Введите правильный номер телефона!")
            
        } else {
            newUser.first_name = self.nameTextField.text!
            newUser.last_name = self.lastNameTextField.text!
            newUser.password = self.passwordTextField.text!
            newUser.phone_number = self.phoneNumberTextField.text!
            sexTextField.text = newUser.is_male == true ? sex[0] : sex[1]
            }
            DataManager.shared.saveUser(username: newUser.phone_number, password: newUser.password)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "Main")
            present(vc, animated: true, completion: nil)
        } else {
            showErrorAlert(message: "Fill required data")
        }
    }
    func setupPickerView() {
        pickerView.delegate = self
        sexTextField.inputView = pickerView
        
        pickerView.backgroundColor = .white
        
        setupToolBar()
    }
    
    func setupToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.barTintColor = Colors.getDarkBlue()
        toolBar.tintColor = .white
        
        let btn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerView))
        toolBar.setItems([btn], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        sexTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissPickerView() {
        view.endEditing(true)
    }
}

extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sex.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sex[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexTextField.text = sex[row]
    }
}
