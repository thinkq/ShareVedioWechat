//
//  RuntimeDump.m
//  ShareVedioWechat
//
//  Created by 赵清 on 2017/5/27.
//  Copyright © 2017年 赵清. All rights reserved.
//

#import "RuntimeDump.h"
#import <objc/runtime.h>

@implementation RuntimeDump

+ (void)ivarWithObject:(id)object{
    NSLog(@"%@",object);
    NSLog(@"==================================================");
    const char *className = object_getClassName(object);
    id class = objc_getClass(className);
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    NSLog(@"---%d",outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
    }
    NSLog(@"--------------------------------------------------");
    unsigned int numIvars = 0;
    Ivar * ivars = class_copyIvarList(class, &numIvars);
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        const char *name = ivar_getName(thisIvar);
        NSString *nameString =  [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        const char *type = ivar_getTypeEncoding(thisIvar);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        NSLog(@"%@,%@",stringType,nameString);
    }
    NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++");
}

@end
