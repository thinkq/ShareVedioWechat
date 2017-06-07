//
//  CLVedioShareManager.h
//  chuchuConsultant
//
//  Created by 赵清 on 2017/5/31.
//  Copyright © 2017年 CuliuKeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLVedioShareManager : NSObject

+ (void)directShareVedio:(NSURL *)url;
+ (void)indirectShareVedio:(NSURL *)url;
+ (void)shareVedioAsFile:(NSURL *)url;
+ (void)indirectShareImage;
+ (void)directShareImage;

@end
