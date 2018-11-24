//
//  ViewController.swift
//  FakeLoacationSample
//
//  Created by adapter on 2018/11/24.
//  Copyright © 2018 adapter00. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    @IBOutlet var map:GMSMapView!
    var locationManager = CLLocationManager()
    private var _observers = [NSKeyValueObservation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let transitionToFakeItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(fakeLocatinButtonClicked(sender:)))
        self.navigationItem.rightBarButtonItem = transitionToFakeItem
        // Do any additional setup after loading the view, typically from a nib.
        map.camera = GMSCameraPosition.camera(withLatitude: CLLocation.myHouse.coordinate.latitude, longitude: CLLocation.myHouse.coordinate.longitude, zoom: 15.0)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        map.isMyLocationEnabled = true
    }
}
extension ViewController {
    @objc func fakeLocatinButtonClicked(sender: UIButton) {
        let fl = CLLocation(latitude: 35.659310,longitude: 139.703518)
        FakeLocationManager.shared.stub(to: fl)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            map.isMyLocationEnabled = true
        }
    }
}

