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
    if (originalMethod && swizzledMethod) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

void wll_hookClassMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector) {
    Method originalMethod = class_getClassMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getClassMethod(swizzledClass, swizzledSelector);
    if (originalMethod && swizzledMethod) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@implementation NSObject (Hook)

+ (void)hook {

    wll_hookMethod(objc_getClass("WEWApplicationLifeCricleObserver"), @selector(applicationDidFinishLaunching), [self class], @selector(hook_applicationDidFinishLaunching));
    //去除水印
    wll_hookMethod(objc_getClass("WEWConversation"), @selector(isConversationSupportWaterMark), [self class], @selector(hook_isConversationSupportWaterMark));

    // NSColor colorWithDeviceWhite
    // this will effect image border color
    wll_hookClassMethod(objc_getClass("NSColor"), @selector(colorWithWhite:alpha:), [self class], @selector(hook_colorWithWhite:alpha:));
    wll_hookClassMethod(objc_getClass("NSColor"), @selector(colorWithWhite:alpha:), [self class], @selector(hook_colorWithWhite:alpha:));
    //
    wll_hookClassMethod(objc_getClass("NSColor"), @selector(colorWithDeviceWhite:alpha:), [self class], @selector(hook_colorWithDeviceWhite:alpha:));
    // this effect cell border color
    wll_hookClassMethod(objc_getClass("NSColor"), @selector(colorWithRed:green:blue:alpha:), [self class], @selector(hook_colorWithRed:green:blue:alpha:));
    // convervation
    wll_hookClassMethod(objc_getClass("WEWColor"), @selector(recentConversationListViewBkgroundColor), [self class], @selector(hook_recentConversationListViewBkgroundColor));
    wll_hookClassMethod(objc_getClass("WEWColor"), @selector(recentConversationListViewSeparatorColor), [self class], @selector(hook_recentConversationListViewSeparatorColor));
    // voice message
    wll_hookClassMethod(objc_getClass("WEWColor"), @selector(voiceMsgTimeLenTextColor), [self class], @selector(hook_voiceMsgTimeLenTextColor));
    wll_hookClassMethod(objc_getClass("WEWColor"), @selector(collectionCellBackgroudColor), [self class], @selector(hook_collectionCellBackgroudColor));
    wll_hookClassMethod(objc_getClass("WEWColor"), @selector(windowTitleBackgroundColor), [self class], @selector(hook_windowTitleBackgroundColor));
    wll_hookClassMethod(objc_getClass("WEWColor"), @selector(buttonNormalTitleColor), [self class], @selector(hook_buttonNormalTitleColor));
    wll_hookClassMethod(objc_getClass("WEWColor"), @selector(colorWithHexString:alpha:), [self class], @selector(hook_colorWithHexString:alpha:));
    // conservation background color
    wll_hookClassMethod(objc_getClass("WEWColor"), @selector(viewBackgroundColor), [self class], @selector(hook_viewBackgroundColor));

    wll_hookClassMethod(objc_getClass("WEWColor"), @selector(sidebarBackgroundColor), [self class], @selector(hook_sidebarBackgroundColor));

    wll_hookClassMethod(objc_getClass("WEWColor"), @selector(recentConversationListViewRedTextColor), [self class], @selector(hook_recentConversationListViewRedTextColor));
    wll_hookClassMethod(objc_getClass("WEWColor"), @selector(recentConversationListViewSummaryColor), [self class], @selector(hook_recentConversationListViewSummaryColor));
    wll_hookClassMethod(objc_getClass("WEWColor"), @selector(chatViewTopBarSeparatorColor), [self class], @selector(hook_chatViewTopBarSeparatorColor));


    wll_hookMethod(objc_getClass("WEWBackgroundColorView"), @selector(backgroundColor), [self class], @selector(hook_backgroundColor));
    wll_hookMethod(objc_getClass("WEWChatHeaderViewController"), @selector(setDisplayGrayColor:), [self class], @selector(hook_setDisplayGrayColor:));
    wll_hookMethod(objc_getClass("WEWGradientBackgroundColorView"), @selector(startColor), [self class], @selector(hook_startColor));
    wll_hookMethod(objc_getClass("WEWGradientBackgroundColorView"), @selector(endColor), [self class], @selector(hook_startColor));
}

- (BOOL)hook_isConversationSupportWaterMark {
    return NO;
}

- (void)hook_applicationDidFinishLaunching {

}

- (void)hook_setDisplayGrayColor:(BOOL)showGray {
    [self hook_setDisplayGrayColor:true];
}

- (NSColor *)hook_startColor {
    NSLog(@"hook start color method");
    return [NSColor blackColor];
}

+ (NSColor *)hook_backgroundColor {
    return [NSColor darkGrayColor];
}

+ (NSColor *)hook_sidebarBackgroundColor {
    return [NSColor grayColor];
}

+ (NSColor *)hook_recentConversationListViewRedTextColor {
    return [NSColor redColor];
}

// conversation list info summary text color
+ (NSColor *)hook_recentConversationListViewSummaryColor {
    return [NSColor whiteColor];
}

+ (NSColor *)hook_recentConversationListViewSeparatorColor {
    return [NSColor darkGrayColor];
}

+ (NSColor *)hook_chatViewTopBarSeparatorColor {
    return [NSColor lightGrayColor];
}

+ (NSColor *)hook_viewBackgroundColor {
    return [NSColor darkGrayColor];
}

+ (NSColor *)hook_colorWithHexString:(NSString *)string alpha:(CGFloat)al {
    NSLog(@"hook_colorWithHexString");
    return [NSColor orangeColor];
}

// real is want to mock colorWithHex
// this will effect cell border style
+ (NSColor *)hook_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [NSColor lightGrayColor];
}


+ (NSColor *)hook_windowTitleBackgroundColor {
    return [NSColor darkGrayColor];
}

+ (NSColor *)hook_buttonNormalTitleColor {
    return [NSColor redColor];
}

// voice message length number color
+ (NSColor *)hook_voiceMsgTimeLenTextColor {
    return [NSColor cyanColor];
}

+ (NSColor *)hook_collectionCellBackgroudColor {
    return [NSColor darkGrayColor];
}

// this will effect default conservation page
+ (NSColor *)hook_colorWithDeviceWhite:(CGFloat)white alpha:(CGFloat)alpha {
    NSLog(@"hook_colorWithDeviceWhite");
    return [NSColor darkGrayColor];
}

// this will effect image border color
+ (NSColor *)hook_colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
//    NSLog(@"hook_colorWithWhite");
    return [NSColor whiteColor];
}

// this will effect conservation list
+ (NSColor *)hook_recentConversationListViewBkgroundColor {
    return [NSColor darkGrayColor];
}


@end
