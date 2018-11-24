//
//  Swizzle_CLLocationManager.m
//  FakeLoacationSample
//
//  Created by adapter on 2018/11/24.
//  Copyright © 2018 adapter00. All rights reserved.
//

#import "RuntimeHandler.h"

@implementation _RuntimeHandler

+(void)handleLoad {
    NSLog(@"Please override RuntimeHandler.handleLoad if you want to use");
}
+(void)handleInitialize {
    NSLog(@"Please override RuntimeHandler.handleInitialize if you want to use");
}

@end


@implementation RuntimeHandler

+(void)initialize {
    [super initialize];
    [self handleInitialize];
}

+ (void)load {
    [super load];
    [self handleLoad];
}

@end
