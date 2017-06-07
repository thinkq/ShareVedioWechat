//
//  CLVedioShareManager.m
//  chuchuConsultant
//
//  Created by 赵清 on 2017/5/31.
//  Copyright © 2017年 CuliuKeji. All rights reserved.
//

#import "CLVedioShareManager.h"
#import "SLComposeViewController+Method.h"
@implementation CLVedioShareManager


+ (void)directShareVedio:(NSURL *)url {
    NSString *test = @"com.tencent.xin.sharetimeline";
    if (![SLComposeViewController isAvailableForServiceType:test]) {
        NSLog(@"或者没有配置相关的帐号");
        return;
    }
    
    // 2.创建分享的控制器
    SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:test];
    if (composeVc == nil){
        NSLog(@"没有安装微信");
        return;
    }
    [composeVc addVideoURL:url];
    
    // 3.弹出分享控制器（以Modal形式弹出）
    UIViewController * rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVc presentViewController:composeVc animated:TRUE completion:nil];
    
    
    // 4.监听用户点击了取消还是发送
    /*
     SLComposeViewControllerResultCancelled,
     SLComposeViewControllerResultDone
     */
    composeVc.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultCancelled) {
            NSLog(@"点击了取消");
        } else {
            NSLog(@"点击了发送");
        }
    };
}


+ (void)indirectShareVedio:(NSURL *)url {
    NSArray *activityItems = @[url];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems
                                                                            applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList];
    
    //给activityVC的属性completionHandler写一个block。
    //用以UIActivityViewController执行结束后，被调用，做一些后续处理。
    UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(UIActivityType activityType, BOOL completed, NSArray * returnedItems, NSError * activityError)
    {
        
        if (completed)
        {
            
        }
        else
        {
            
        }
    };
    
    // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
    activityVC.completionWithItemsHandler = myBlock;
    
    UIViewController * rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVc presentViewController:activityVC animated:TRUE completion:nil];
}

+ (void)shareVedioAsFile:(NSURL *)url {
    NSString *test = @"com.tencent.xin.sharetimeline";
    
    //                                        test = @"com.tencent.mqq.ShareExtension";
    if (![SLComposeViewController isAvailableForServiceType:test]) {
        NSLog(@"或者没有配置相关的帐号");
        return;
    }
    
    SLComposeViewController *composeVc1 = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
    // 2.创建分享的控制器
    SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:test];
    if (composeVc == nil){
        NSLog(@"没有安装微信");
        return;
    }
    // 2.1.添加分享的文字
    [composeVc setInitialText:@"balabalabala..."];
    
    // 2.2.添加一个图片
    [composeVc addImage:[UIImage imageNamed:@"lanuch"]];
    
    // 2.3.添加一个链接
    [composeVc addURL:url];
    
    
    // 3.弹出分享控制器（以Modal形式弹出）
    UIViewController * rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVc presentViewController:composeVc animated:TRUE completion:nil];
    
    
    // 4.监听用户点击了取消还是发送
    /*
     SLComposeViewControllerResultCancelled,
     SLComposeViewControllerResultDone
     */
    composeVc.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultCancelled) {
            NSLog(@"点击了取消");
        } else {
            NSLog(@"点击了发送");
        }
    };
}

+ (void)indirectShareImage {
    UIImage *imageToShareOne = [UIImage imageNamed:@"狮子"];
    UIImage *imageToShareTwo = [UIImage imageNamed:@"老虎"];
    
    NSArray *activityItems = @[imageToShareOne, imageToShareTwo];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems
                                            
                                                                            applicationActivities:nil];
    
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                         
                                         UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    
    // 3.弹出分享控制器（以Modal形式弹出）
    UIViewController * rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVc presentViewController:activityVC animated:TRUE completion:nil];
}

+ (void)directShareImage {
    NSString *test = @"com.tencent.xin.sharetimeline";
    if (![SLComposeViewController isAvailableForServiceType:test]) {
        NSLog(@"或者没有配置相关的帐号");
        return;
    }
    
    // 2.创建分享的控制器
    SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:test];
    if (composeVc == nil){
        NSLog(@"没有安装微信");
        return;
    }
    // 2添加图片
    [composeVc addImage:[UIImage imageNamed:@"狮子"]];
    [composeVc addImage:[UIImage imageNamed:@"老虎"]];
    
    // 3.弹出分享控制器（以Modal形式弹出）
    UIViewController * rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVc presentViewController:composeVc animated:TRUE completion:nil];
    
    // 4.监听用户点击了取消还是发送
    /*
     SLComposeViewControllerResultCancelled,
     SLComposeViewControllerResultDone
     */
    composeVc.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultCancelled) {
            NSLog(@"点击了取消");
        } else {
            NSLog(@"点击了发送");
        }
    };
}



@end
