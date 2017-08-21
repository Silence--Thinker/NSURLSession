//
//  AFNetworkingController.m
//  NSURLSession
//
//  Created by Silence on 2017/8/15.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "AFNetworkingController.h"

@interface AFNetworkingController ()<NSURLSessionDelegate,NSURLSessionTaskDelegate>

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
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.kuaidi100.com/query?type=yuantong&postid=11111111111"];
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

// MARK - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"%s", __func__);
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"%s", __func__);
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSLog(@" dict=>> %@",dict);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"%s", __func__);
    if(error == nil) {
        NSLog(@"Download is Succesfull");
    }
    else{
        NSLog(@"Error %@",[error userInfo]);
    }
}

/*

// MARK - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"%s", __func__);
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    
//    completionHandler(NSURLSessionResponseAllow)
    NSLog(@"%@", session);
    NSLog(@"%s", __func__);
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)sessio {
    NSLog(@"%s", __func__);
}


*/
@end

