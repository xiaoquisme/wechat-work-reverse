//
//  main.m
//  hookwework
//
//  Created by Lianqing Qu  on 5/29/20.
//  Copyright © 2020 Lianqing Qu . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+hook.h"

static void __attribute__((constructor)) initialize(void) {
    NSLog(@"++++++++ WorkWechat Plugin loaded ++++++++");
    [NSObject hook];
}

