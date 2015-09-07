//
//  CDVMyPlugin.h
//  WebDemo
//
//  Created by YMY on 15/8/15.
//  Copyright (c) 2015年 dasheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVCommandDelegateImpl.h>
#import <Cordova/CDVCommandQueue.h>

@interface CDVMyPlugin : CDVPlugin

@property (nonatomic, copy) NSString* callbackID;

// Instance Method

- (void)print:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;


@end
