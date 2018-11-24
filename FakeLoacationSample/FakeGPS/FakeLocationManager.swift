//
//  FakeLocationManager.swift
//  FakeLoacationSample
//
//  Created by adapter on 2018/11/25.
//  Copyright © 2018 adapter00. All rights reserved.
//

import CoreLocation

class FakeLocationManager: RuntimeHandler {
    static var shared = FakeLocationManager()
    private var locationMonitor: [Int: CLLocationManager] = [:]
    private var locationDeleagteMonitor: [Int: CLLocationManagerDelegate] = [:]
    private var stubLocation: CLLocation? = nil
    private override init() {
        super.init()
    }

    func addLocationBinder(binder: CLLocationManager, delegate: CLLocationManagerDelegate) {
        let binderKey = binder.hash
        let delegateKey = binder.hash
        self.locationMonitor[binderKey] = binder
        self.locationDeleagteMonitor[delegateKey] = delegate
    }
    
    open func stub(to fakeLocation: CLLocation) {
        self.stubLocation = nil
        self.dispatchLocations(locations: [fakeLocation])
        self.stubLocation = fakeLocation
    }
    
    open func resetStub() {
        self.stubLocation = nil
    }

    func swizzleCLLocationManagerDelegate() {
        let fromSelector = #selector(setter: CLLocationManager.delegate)
        guard let from = class_getInstanceMethod(CLLocationManager.self, fromSelector),
            let to = class_getInstanceMethod(CLLocationManager.self, #selector(CLLocationManager.swizzleSetDelegate(delegate:))) else {
                fatalError("Swizzle is failed")
        }
        if class_addMethod(CLLocationManager.self,
                           fromSelector,
                           method_getImplementation(to),
                           method_getTypeEncoding(to)) {
            class_replaceMethod(CLLocationManager.self, fromSelector, method_getImplementation(to),  method_getTypeEncoding(from))
        } else {
            method_exchangeImplementations(from, to)
        }
    }
    
    private func dispatchLocations(locations: [CLLocation]) {
        self.locationMonitor.forEach {(_, manager) in
            self.locationManager(manager, didUpdateLocations: locations)
        }
    }
    
    private func delegate(for key:CLLocationManager) throws -> CLLocationManagerDelegate {
        if let delegate = locationDeleagteMonitor[key.hash] {
            return delegate
        } else {
            fatalError("\(key.description) is not registered")
        }
    }
}

extension FakeLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let d = try! delegate(for: manager)
        if let delegate = try? delegate(for: manager),
            delegate.responds(to: #selector(locationManager(_:didUpdateLocations:))) {
            if let loc = stubLocation {
                d.locationManager!(manager, didUpdateLocations: [loc])
            } else {
                d.locationManager!(manager, didUpdateLocations: locations)
            }
        }
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        if let delegate =  try? delegate(for: manager),
            delegate.responds(to: #selector(locationManagerDidPauseLocationUpdates(_:))) {
            delegate.locationManagerDidPauseLocationUpdates!(manager)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if let delegate =  try? delegate(for: manager),
            delegate.responds(to: #selector(locationManager(_:didUpdateHeading:))) {
            delegate.locationManager!(manager, didUpdateHeading: newHeading)
        }
    }
}
