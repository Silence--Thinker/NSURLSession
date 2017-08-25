//
//  XJDownloadTaskController.m
//  NSURLSession
//
//  Created by Silence on 2017/8/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

// http://sw.bos.baidu.com/sw-search-sp/software/9629a8d93b17f/teamviewer_11.0.65280.dmg
#import "XJDownloadTaskController.h"


@interface XJDownloadTaskController ()
<NSURLSessionDelegate, NSURLSessionDownloadDelegate>


@end
@implementation XJDownloadTaskController {
    NSData *_resumeData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)ss {
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue new]];
    NSURL *url = [NSURL URLWithString:@"http://sw.bos.baidu.com/sw-search-sp/software/9629a8d93b17f/teamviewer_11.0.65280.dmg"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    
    [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        _resumeData = resumeData;
    }];
    [task resume];
}

// MARK - NSURLSessionDelegate, NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {

}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {

}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {

}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

@end
