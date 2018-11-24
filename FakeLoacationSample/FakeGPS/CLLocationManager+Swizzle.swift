//
//  CLLocationManager+Swizzle.swift
//  FakeLoacationSample
//
//  Created by adapter on 2018/11/25.
//  Copyright © 2018 adapter00. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationManager {
    @objc func swizzleSetDelegate(delegate: CLLocationManagerDelegate?) {
        if let delegate = delegate {
            self.swizzleSetDelegate(delegate: FakeLocationManager.shared)
            FakeLocationManager.shared.addLocationBinder(binder: self, delegate: delegate)
            guard let proto = objc_getProtocol("CLLocationManagerDelegate") else {
                return
            }
            var count:UInt32 = 0
            let methods = protocol_copyMethodDescriptionList(proto, false, true, &count)
            defer { free(methods) }
            (0..<count).forEach { (i) in
                if let sel = methods?[Int(i)].name, !FakeLocationManager.shared.responds(to: sel){
                    //TODO: rest delegate method
                    //                    assert(false, "Do not implements Delegate is \(delegate.description), Selector:\(sel.description)")
                }
            }
        } else {
            self.swizzleSetDelegate(delegate: delegate)
        }
    }
}

