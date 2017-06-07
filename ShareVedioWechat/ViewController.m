//
//  ViewController.m
//  ShareVedioWechat
//
//  Created by 赵清 on 2017/5/26.
//  Copyright © 2017年 赵清. All rights reserved.
//

#import "ViewController.h"
#import "CLVedioShareManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [CLVedioShareManager directShareImage];
}


@end
