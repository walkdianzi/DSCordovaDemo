//
//  CDVMyPlugin.m
//  WebDemo
//
//  Created by YMY on 15/8/15.
//  Copyright (c) 2015年 dasheng. All rights reserved.
//

#import "CDVMyPlugin.h"

@implementation CDVMyPlugin


-(void)print:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    
    // 这是classid,在下面的PluginResult进行数据的返回时,将会用到它
    self.callbackID = [arguments pop];
    
    // 得到Javascript端发送过来的字符串
    NSString *stringObtainedFromJavascript = [arguments objectAtIndex:0];
    
    // 创建我们要返回给js端的字符串
    NSMutableString *stringToReturn = [NSMutableString stringWithString: @"我是返回的:"];
    
    [stringToReturn appendString: stringObtainedFromJavascript];
    
    // Create Plugin Result
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: stringToReturn];
    
    NSLog(@ "%@",stringToReturn);
    
    // 检查发送过来的字符串是否等于"HelloWorld",如果不等,就以PluginResult的Error形式返回
    if ([stringObtainedFromJavascript isEqualToString:@"HelloWorld"] == YES){
        // Call the javascript success function
//        [self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackID];
        
    } else{
        // Call the javascript error function
        //[self writeJavascript: [pluginResult toErrorCallbackString:self.callbackID]];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackID];
    }}

@end
