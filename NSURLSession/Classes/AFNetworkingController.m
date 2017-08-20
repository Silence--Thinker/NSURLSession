//
//  AFNetworkingController.m
//  NSURLSession
//
//  Created by Silence on 2017/8/15.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "AFNetworkingController.h"

@interface AFNetworkingController ()<NSURLSessionDelegate>

@end
@implementation AFNetworkingController

- (void)viewDidLoad {
    [super viewDidLoad];
//    https://tcc.taobao.com/cc/json/mobile_tel_segment.htm?tel=18755057919
    [self URLSessionRequest];
}

- (void)URLSessionRequest {
//    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:queue];
    
    
    NSURL *url = [NSURL URLWithString:@"https://tcc.taobao.com/cc/json/mobile_tel_segment.htm?tel=18755057919"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
//    request.m
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%s", __func__);
//        NSLog(@"%@", data);
//    }];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}

// MARK - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"%s", __func__);
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    
    
    NSLog(@"%@", session);
    NSLog(@"%s", __func__);
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)sessio {
    NSLog(@"%s", __func__);
}
@end

