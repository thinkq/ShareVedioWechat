# ShareVedioWechat
用Social.framework分享图片视频到微信

app内分享多张图片到朋友圈
````
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
````

app内分享视频到微信
````
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
````

博客说明：[iOS的Share Extension直接分享视频到微信](http://www.jianshu.com/p/9088e634e7aa)
