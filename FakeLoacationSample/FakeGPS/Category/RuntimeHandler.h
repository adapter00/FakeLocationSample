//
//  Swizzle_CLLocationManager.h
//  FakeLoacationSample
//
//  Created by adapter on 2018/11/24.
//  Copyright © 2018 adapter00. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface _RuntimeHandler : NSObject

+(void)handleLoad;

+(void)handleInitialize;

@end

@interface RuntimeHandler: _RuntimeHandler
@end

NS_ASSUME_NONNULL_END
