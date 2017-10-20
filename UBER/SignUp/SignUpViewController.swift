//
//  SignUpViewController.swift
//  UBER
//
//  Created by ZYFAR on 21.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var sexTextField: UITextField!
    let sex = ["М" , "Ж"]
    var selected: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPickerView()
    }
    
    func setupPickerView() {
        let pickerView = UIPickerView()
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
        selected = sex[row]
        sexTextField.text = selected
    }
}
