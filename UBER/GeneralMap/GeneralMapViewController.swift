//
//  GeneralMapViewController.swift
//  UBER
//
//  Created by ZYFAR on 21.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GeneralMapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var generalMapView: UIView!
    var map: GMSMapView!
    var helpBtn = UIButton()
    var markers = [[42.905465, 74.563014] ,
                   [42.866411, 74.620435] ,
                   [42.856219, 74.597862] ,
                   [42.840235, 74.547737] ,
                   [42.827049, 74.624526]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Карта заявок"
        setupGoogleMap()
        setupMarkers()
        setupHelpBtn()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return true
    }
    
    func setupGoogleMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 42.8706253, longitude: 74.5724552, zoom: 10)
        map = GMSMapView.map(withFrame: self.generalMapView.frame, camera: camera)
        map.delegate = self
        map.settings.myLocationButton = true
        map.isMyLocationEnabled = true
        map.mapType = .terrain
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(map)
    }
    
    func setupMarkers() {
        for i in markers {
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: i[0], longitude: i[1]))
            marker.icon = UIImage(named: "marker")
            marker.map = map
        }
    }
    
    func setupHelpBtn() {
        helpBtn.frame = CGRect(x: view.frame.midX - 55, y: view.frame.height - 95, width: 110, height: 40)
        helpBtn.setTitle("Помочь", for: .normal)
        helpBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        helpBtn.setTitleColor(.white, for: .normal)
        helpBtn.layer.cornerRadius = 20
        helpBtn.backgroundColor = Colors.getDarkBlue()
        helpBtn.addTarget(self, action: #selector(helpBtnClicked), for: .touchUpInside)
        view.addSubview(helpBtn)
    }
    
    @objc func helpBtnClicked() {
        
    }
}
