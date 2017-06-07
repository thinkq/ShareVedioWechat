//
//  CLVedioDownloadManager.h
//  chuchuConsultant
//
//  Created by 赵清 on 2017/5/31.
//  Copyright © 2017年 CuliuKeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CLVedioDownloadManager : NSObject
+ (NSString *)cachedFileNameForKey:(NSString *)key;
+ (NSString *)cachedFilePathForFileName:(NSString *)fileName;
+ (void)save:(NSURL*)url fileName:(NSString *)fileName;
+ (NSString *)getAssetURLforFile:(NSString *)fileName;
@end
