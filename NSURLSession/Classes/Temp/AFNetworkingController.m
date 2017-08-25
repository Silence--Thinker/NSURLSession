//
//  AFNetworkingController.m
//  NSURLSession
//
//  Created by Silence on 2017/8/15.
//  Copyright © 2017年 Silence. All rights reserved.
//

/*
 http://sw.bos.baidu.com/sw-search-sp/software/9629a8d93b17f/teamviewer_11.0.65280.dmg
 
 http://www.kuaidi100.com/query?type=yuantong&postid=11111111111
 */


#import "AFNetworkingController.h"
#import <CFNetwork/CFHTTPStream.h>

@interface AFNetworkingController ()
<NSURLSessionDelegate,NSURLSessionTaskDelegate,
NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, strong) NSURLSession *session;

@end
@implementation AFNetworkingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // NSURLSessionDataTask
    [self URLSessionDataTaskRequest];
    
    // NSURLSessionDownloadTask
//    [self URLSessionDownloadTaskRequest];
}

- (void)URLSessionDataTaskRequest {
//    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:queue];
    
    NSURL *url = [NSURL URLWithString:@"http://sw.bos.baidu.com/sw-search-sp/software/9629a8d93b17f/teamviewer_11.0.65280.dmg"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
//    request.m
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%s", __func__);
//        NSLog(@"%@", data);
//    }];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}

- (void)URLSessionDownloadTaskRequest {
    //  // 图片 https://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230418068437443.jpg
    
    /*
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://sw.bos.baidu.com/sw-search-sp/software/9629a8d93b17f/teamviewer_11.0.65280.dmg"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@", location);
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSLog(@"%@", path);
        NSLog(@"%@", response);
        NSLog(@"%@", error);
    }];
    */
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue new]];
    self.session = session;
    NSURL *url = [NSURL URLWithString:@"http://sw.bos.baidu.com/sw-search-sp/software/9629a8d93b17f/teamviewer_11.0.65280.dmg"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    self.task = task;
    [task resume];
//    NSURLSessionDownloadDelegate
}



/*=============================NSURLSessionDelegate=============================*/

/**
 当一个session遇到系统错误或者未检测到的错误的时候，就会调用这个方法。
 */
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"%s==%@", __func__, error);
}

/**
 当请求需要认证、或者https证书认证的时候，我们就需要在这个方法里面处理。
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"%s", __func__);
}

/**
 如果应用进入后台、这个方法会被调用。我们在这里可以对session发起的请求做各种操作比如请求完成的回调等。
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    NSLog(@"%s", __func__);
}




/*=============================NSURLSessionTaskDelegate=============================*/

/*
 当请求重定向的时候调用这个方法。我们必须设置一个新的`NSURLRequest`对象传入completionHandler来重定向新的请求，
 但是当`session`是background模式的时候，这个方法不会被调用。
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    NSLog(@"%s", __func__);
}

/*
 当请求需要认证的时候调用这个方法。如果没有实现这个代理，那么请求认证这个过程不会被调用。
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"%s", __func__);
}

/*
 如果请求需要一个新的请求体时，这个方法就会被调用。比如认证失败的时候，我们可以通过这个机会重新认证。
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream * _Nullable bodyStream))completionHandler {
    NSLog(@"%s", __func__);
}

/*
 当我们上传数据的时候，我们可以通过这个代理方法获取上传进度。
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    NSLog(@"%s", __func__);
}

/*
 当task的统计信息收集好了以后，调用这个方法。
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics {
    NSLog(@"%s", __func__);
}
/*
 当一个task出错的时候，会调用这个方法。如果error是nil，也会调用这个方法，表示task完成。
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSLog(@"%s===%@", __func__, error);
    
}


/*=============================NSURLSessionDataDelegate=============================*/

/*
 当一个task接收到返回信息。当所有信息都接收完毕以后，completionHandler会被调用。
 我们可以在这里取消一个网络请求或者把一个datatask转换为downloadtask。如果没有实现这个代理方法，
 我们也可以通过task的response属性获取到对应的数据。background模式的uploadtask不会调用这个方法。
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"%s", __func__);
}

/*
 当一个datatask转换为一个downloadtask以后会调用。将来不会将任何消息发送到dataTask
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    NSLog(@"%s", __func__);
}

/*
 暂时忽略，这个是和数据流相关的。不管了
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask {
    NSLog(@"%s", __func__);
}

/*
 当data可以使用的时候，调用这个方法。我们可以在这里获取data。
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    NSLog(@"%s", __func__);
}

/*
 允许我们在这里调用completionHandler缓存data，或者传入nil来禁止缓存
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler {
    NSLog(@"%s", __func__);
}


/*=============================NSURLSessionDownloadDelegate=============================*/

/**
 当一个下载task任务完成以后，这个方法会被调用。我们可以在这里移动或者复制download的数据
 @param location 下载完成后的本地临时文件地址
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"%s===%@", __func__, location);
}

/**
 获取下载进度
 @param bytesWritten 本次接收数据的大小
 @param totalBytesWritten 总共接收数据的大小
 @param totalBytesExpectedToWrite 预留字节总数。总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    NSLog(@"%@", downloadTask.taskDescription);
    NSLog(@"%@", downloadTask.response.URL);
    NSLog(@"%@", downloadTask.response.suggestedFilename);
    
    
    NSLog(@"%0.3lld===%0.3lld===%lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    
    double progress = (double)totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"进度百分比 = %0.8f", progress);
    if (progress >= 0.2) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            [downloadTask suspend];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.task resume];
        });
    });
    }
//    NSByteCountFormatter
//    NSData *data = [NSData dataWithBytes:0 length:0]
//    [session downloadTaskWithResumeData:totalBytesWritten];
}

/**
 重启一个下载任务(比如下载一半后停止然后过一点时间继续)。如果下载出错，`NSURLSessionDownloadTaskResumeData`
 里面包含重新开始下载的数据。
 @param fileOffset <#fileOffset description#>
 @param expectedTotalBytes <#expectedTotalBytes description#>
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    
    NSLog(@"didResumeAtOffset==%0.3lld", fileOffset);
    NSLog(@"expectedTotalBytes==%0.3lld", expectedTotalBytes);
}
@end

