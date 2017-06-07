//
//  SLComposeViewController+Method.m
//  ShareVedioWechat
//
//  Created by 赵清 on 2017/5/26.
//  Copyright © 2017年 赵清. All rights reserved.
//

#import "SLComposeViewController+Method.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation SLComposeViewController (Method)

- (BOOL)addVideoURL:(NSURL *)url {
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithItem:url typeIdentifier:(NSString *)kUTTypeQuickTimeMovie];    
    NSExtensionItem *extensionItem = [NSExtensionItem new];
    extensionItem.attachments = [NSArray arrayWithObject:itemProvider];
    
    return [self performSelector:@selector(addExtensionItem:) withObject:extensionItem];
}

@end
