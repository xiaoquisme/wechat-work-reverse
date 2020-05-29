//
//  hook.m
//  hookwework
//
//  Created by Lianqing Qu  on 5/29/20.
//  Copyright © 2020 Lianqing Qu . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <objc/runtime.h>

#import "NSObject+hook.h"


void wll_hookMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    if(originalMethod && swizzledMethod) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@implementation NSObject (Hook)

+(void) hook{

    wll_hookMethod(objc_getClass("WEWApplicationLifeCricleObserver"), @selector(applicationDidFinishLaunching), [self class], @selector(hook_applicationDidFinishLaunching));
    

    //去除水印
    wll_hookMethod(objc_getClass("WEWConversation"), @selector(isConversationSupportWaterMark), [self class], @selector(hook_isConversationSupportWaterMark));
}

- (BOOL)hook_isConversationSupportWaterMark{
    return NO;
}

- (void)hook_applicationDidFinishLaunching{
    // [self addPlugin];
}
@end
