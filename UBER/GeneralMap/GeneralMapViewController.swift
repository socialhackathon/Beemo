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

    @IBOutlet var infoView: UIView!
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
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        showInfoView()
        return true
    }
    
    @IBAction func dismissInfoView(_ sender: UIButton) {
        hideInfoView()
    }
    @IBAction func helpBtn(_ sender: Any) {
        hideInfoView()
        showSuccessAlert(message: "Success")
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
}

extension GeneralMapViewController {
    
    func showInfoView() {
        self.view.addSubview(infoView)
        infoView.center = CGPoint(x: 0, y: 140)
        infoView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.infoView.alpha = 1
            self.infoView.center = CGPoint(x: self.view.bounds.midX, y: 140)
        }
    }
    
    func hideInfoView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.infoView.center = CGPoint(x: self.view.bounds.size.width, y: 140)
            self.infoView.alpha = 0
        }) { (success) in
            self.infoView.removeFromSuperview()
        }
    }
}
