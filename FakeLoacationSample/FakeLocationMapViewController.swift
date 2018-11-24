//
//  FakeLocationMapViewController.swift
//  FakeLoacationSample
//
//  Created by adapter on 2018/11/24.
//  Copyright © 2018 adapter00. All rights reserved.
//

import UIKit
import MapKit

class FakeLocationMapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.setCenter(CLLocation.myHouse.coordinate, animated: false)
    }
    
}

extension FakeLocationMapViewController: MKMapViewDelegate {
    
}

