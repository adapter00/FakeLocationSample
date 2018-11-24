//
//  RuntimeHandler.swift
//  FakeLoacationSample
//
//  Created by adapter on 2018/11/25.
//  Copyright © 2018 adapter00. All rights reserved.
//

import Foundation


// This is entrypoint for Method Swizzle
// All subclass of `CLLocationManagerDelegate` is swizzled
extension RuntimeHandler {
    open override class func handleLoad() {
        FakeLocationManager.shared.swizzleCLLocationManagerDelegate()
    }
}
