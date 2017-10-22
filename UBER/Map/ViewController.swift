//
//  ViewController.swift
//  UBER
//
//  Created by ZYFAR on 21.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {
    
    struct Coordinate {
        var coordinate: CLLocationCoordinate2D
        var number: Int
    }
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeTF: UITextField!
    
    var map: GMSMapView!
    var points: [Coordinate] = []
    let timePicker = UIDatePicker()
    let resetButton = UIButton()
    let confirmButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Карта"
        setupGoogleMap()
        addResetButton()
        addConfirmButton()
        setupTimePicker()
        DatePicker()
    }
    
    @IBAction func showProfileInfo(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ProfileInfoViewController") as! ProfileInfoViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func confirmTime(_ sender: UIButton) {
        let order = Order()
        ServerManager.shared.addOrder(order: order, completion: {
        }, error: showErrorAlert)
        
        hideTimeView()
        showSuccessAlert(message: "Ваш запрос успешно отправлен!")
    }
    
    @IBAction func dismissTime(_ sender: UIButton) {
        hideTimeView()
    }
 
    func setupGoogleMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 42.8706253, longitude: 74.5724552, zoom: 10)
        map = GMSMapView.map(withFrame: self.mapView.frame, camera: camera)
        map.delegate = self
        map.settings.myLocationButton = true
        map.isMyLocationEnabled = true
        map.mapType = .terrain
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(map)
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.icon = UIImage(named: "marker")
        marker.map = map
        setPoint(coordinate)
    }
    
    func setPoint(_ coordinate: CLLocationCoordinate2D) {
        let coord = Coordinate(coordinate: coordinate, number: self.points.count)
        points.append(coord)
        addLines()
    }
    
    func addLines() {
        let path = GMSMutablePath()
        for p in points {
            path.add(p.coordinate)
        }
        
        let line = GMSPolyline(path: path)
        line.strokeWidth = 2.0
        line.strokeColor = UIColor.green
        line.map = map
    }
    
    func addResetButton() {
        resetButton.frame = CGRect(x: 5, y: view.frame.height - 95, width: 90, height: 40)
        resetButton.setTitle("Отменить", for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.layer.cornerRadius = 20
        resetButton.backgroundColor = Colors.getDarkBlue()
        resetButton.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
        view.addSubview(resetButton)
    }
    
    func addConfirmButton() {
        confirmButton.frame = CGRect(x: 100, y: view.frame.height - 95, width: 110, height: 40)
        confirmButton.setTitle("Подтвердить", for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.layer.cornerRadius = 20
        confirmButton.backgroundColor = Colors.getDarkBlue()
        confirmButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
        view.addSubview(confirmButton)
    }
    
    @objc func resetButtonClicked() {
        points.removeAll()
        map.clear()
    }
    
    @objc func confirmButtonClicked() {
        
        if points.count > 1 {
            showTimeView()
        } else {
            showErrorAlert(message: "Нарисуйте на карте маркер")
        }
    }
    
    func showTimeView() {
        confirmButton.isHidden = true
        resetButton.isHidden = true
        
        self.view.addSubview(timeView)
        timeView.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height)
        timeView.alpha = 0

        UIView.animate(withDuration: 0.4) {
            self.timeView.alpha = 1
            self.timeView.center = self.view.center
        }
    }
    
    func hideTimeView() {
        confirmButton.isHidden = false
        resetButton.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.timeView.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height)
            self.timeView.alpha = 0
        }) { (success) in
            self.timeView.removeFromSuperview()
        }
    }
    
    func setupTimePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.barTintColor = Colors.getDarkBlue()
        toolBar.tintColor = .white
        
        let btn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerView))
        toolBar.setItems([btn], animated: true)
        
        timePicker.backgroundColor = .white
        timePicker.datePickerMode = UIDatePickerMode.time
        timeTF.inputAccessoryView = toolBar
        timeTF.inputView = timePicker
    }
    
    @objc func dismissPickerView() {
        DatePicker()
        view.endEditing(true)
    }
    
    func DatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        timeTF.text = dateFormatter.string(from: timePicker.date)
    }
}

