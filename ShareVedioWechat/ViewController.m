//
//  ViewController.m
//  ShareVedioWechat
//
//  Created by 赵清 on 2017/5/26.
//  Copyright © 2017年 赵清. All rights reserved.
//

#import "ViewController.h"
#import "CLVedioShareManager.h"
#import "CLVedioDownloadManager.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import <AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [CLVedioShareManager directShareImage];
    
    [self shareVedioWithUrl:@"http://nettuts.s3.amazonaws.com/763_sammyJSIntro/trailer_test.mp4"];
}

- (void)shareVedioWithUrl:(NSString *)url {
    NSString *fileName = [CLVedioDownloadManager cachedFileNameForKey:url];
    NSString *filePath = [CLVedioDownloadManager cachedFilePathForFileName:fileName];
    // 下载目的路径
    NSURL *filePathUrl = [NSURL fileURLWithPath:filePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSLog(@"vedio存在于沙盒中");
        NSString *assetURLString = [CLVedioDownloadManager getAssetURLforFile:fileName];
        if (assetURLString && assetURLString.length > 0) {
            NSURL *assetURL = [NSURL URLWithString:assetURLString];
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                if (asset) {
                    NSLog(@"vedio存在于相册中");
                    [CLVedioShareManager directShareVedio:assetURL];
                }else {
                    NSLog(@"asset不存在（本地相册中视频被删除）");
                    [CLVedioDownloadManager save:filePathUrl fileName:fileName];
                }
            } failureBlock:^(NSError *error) {
                NSLog(@"asset不存在（本地相册中视频被删除）");
                [CLVedioDownloadManager save:filePathUrl fileName:fileName];
            }];
        }else {
            NSLog(@"assetURL不存在");
            [CLVedioDownloadManager save:filePathUrl fileName:fileName];
        }
    }
    else {
        NSLog(@"沙盒中没有该vedio文件");
        [self downloadVideoWithUrl:url filePath:filePathUrl fileName:fileName];
    }
}

#pragma mark - 下载视频
- (void)downloadVideoWithUrl:(NSString *)url filePath:(NSURL *)filePathUrl fileName:(NSString *)fileName {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){
        NSLog(@"%@",downloadProgress);
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return filePathUrl;
    } completionHandler:^(NSURLResponse *response, NSURL *filePathUrl, NSError *error) {
        // 从沙盒保存到相册
        [CLVedioDownloadManager save:filePathUrl fileName:fileName];
    }];
    [task resume];
}


@end
