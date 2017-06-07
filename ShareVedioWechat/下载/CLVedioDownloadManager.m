//
//  CLVedioDownloadManager.m
//  chuchuConsultant
//
//  Created by 赵清 on 2017/5/31.
//  Copyright © 2017年 CuliuKeji. All rights reserved.
//

#import "CLVedioDownloadManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "CLVedioShareManager.h"

#define ShareVedioKey @"ShareVedioKey"

@interface CLVedioDownloadManager()

@end

@implementation CLVedioDownloadManager

+ (NSString *)cachedFilePathForFileName:(NSString *)fileName {
    NSArray *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [document objectAtIndex:0];
    NSString *desPath = [documentPath stringByAppendingPathComponent:fileName];
    return desPath;
}

+ (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG) strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    filename = [NSString stringWithFormat:@"%@.mp4",filename];
    
    return filename;
}

+ (void)save:(NSURL*)url fileName:(NSString *)fileName{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeVideoAtPathToSavedPhotosAlbum:url
                                completionBlock:^(NSURL *assetURL, NSError *error) {
                                    if (error) {
                                        NSLog(@"保存视频到相册失败:%@",error);
                                    } else {
                                        NSLog(@"保存视频到相册成功:%@",assetURL);
                                        [CLVedioShareManager directShareVedio:assetURL];
                                        // 保存到本地 key:fileName value assetURL
                                        [CLVedioDownloadManager saveAssetURL:assetURL fileName:fileName];
                                    }
                                }];
}

+ (void)saveAssetURL:(NSURL *)assetURL fileName:(NSString *)fileName {
    NSMutableDictionary *vedioDictionary = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [vedioDictionary addEntriesFromDictionary:[userDefaults dictionaryForKey:ShareVedioKey]];
    [vedioDictionary setValue:[assetURL absoluteString] forKey:fileName];
    NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:vedioDictionary];
    [userDefaults setValue:dictionary forKey:ShareVedioKey];
    [userDefaults synchronize];
}

+ (NSString *)getAssetURLforFile:(NSString *)fileName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryForKey:ShareVedioKey];
    NSString *assetURL = [dic objectForKey:fileName];
    if (assetURL && assetURL.length > 0) {
        return assetURL;
    }
    return nil;
}

@end
