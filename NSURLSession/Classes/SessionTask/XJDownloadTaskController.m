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

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;

@property (nonatomic, weak) IBOutlet UILabel *totalBytesLabel;
@property (nonatomic, weak) IBOutlet UILabel *didWriteLabel;

// URLSession
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) NSURLSessionDownloadTask *downTask;
@property (nonatomic, strong) NSData *resumeData;
@end
@implementation XJDownloadTaskController {
//    NSData *_resumeData;
    int64_t _totalBytesWritten;      // 已经下载数据大小
    int64_t _totalBytesExpectedToWrite; // 文件总大小
}
//@dynamic resumeData;

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialzeDownloadTaskVariablesValue];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.session invalidateAndCancel];
}

- (void)initialzeDownloadTaskVariablesValue {
    
    _totalBytesWritten = [[self rusumeValueForKey:@"totalBytesWritten"] integerValue];
    _totalBytesExpectedToWrite = [[self rusumeValueForKey:@"totalBytesExpectedToWrite"] integerValue];
    
    // sessionConfig
    _sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // session
    _session = [NSURLSession sessionWithConfiguration:_sessionConfig delegate:self delegateQueue:[NSOperationQueue new]];
    
    // request
    NSURL *url = [NSURL URLWithString:@"http://sw.bos.baidu.com/sw-search-sp/software/9629a8d93b17f/teamviewer_11.0.65280.dmg"];
    _request = [NSMutableURLRequest requestWithURL:url];
//    if (self.resumeData) {
//        NSInteger currentSize = _totalBytesWritten;
//        NSString *range = [NSString stringWithFormat:@"bytes=%zd-", currentSize];
//        [_request setValue:range forHTTPHeaderField:@"Range"];
//    }
    
    // downTask
    _downTask = [_session downloadTaskWithRequest:_request];
    
    if (_totalBytesExpectedToWrite) {
        float progress = (float)_totalBytesWritten / _totalBytesExpectedToWrite;
        [self.progressView setProgress:progress animated:NO];
    }
}

- (NSData *)resumeData {
    if (_resumeData) {
        return _resumeData;
    }
    NSData *data = [NSData dataWithContentsOfFile:self.rusumePath];
    if (data) {
        return data;
    }
    return nil;
}

//- (void)setResumeData:(NSData *)resumeData {
//    _resumeData = resumeData;
//    [resumeData writeToFile:self.rusumePath atomically:YES];
//}

- (NSString *)rusumePath {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [documentPath stringByAppendingPathComponent:@"downTaskResumeData"];
    return path;
}

- (NSString *)rusemeInfoPath {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [documentPath stringByAppendingPathComponent:@"downTaskResumeInfo.plist"];
    return path;
}

- (void)setRusumeValue:(id)value forKey:(id <NSCopying>)key {

    NSString *path = self.rusemeInfoPath;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
    }
    [dict setObject:value forKey:key];
    [dict writeToFile:path atomically:YES];
}

- (id)rusumeValueForKey:(id <NSCopying>)key {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:self.rusemeInfoPath];
    if (!dict) {
        return nil;
    }
    id value = [dict objectForKey:key];
    return value;
}

// MARK - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"%s", __func__);
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"%s", __func__);
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    NSLog(@"%s", __func__);
}

// MARK - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    NSLog(@"%s", __func__);
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"%s", __func__);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream * _Nullable bodyStream))completionHandler {
    NSLog(@"%s", __func__);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    NSLog(@"%s", __func__);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics {
    NSLog(@"%s", __func__);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSLog(@"%s===%@", __func__, error);
    [self setRusumeValue:@(_totalBytesWritten) forKey:@"totalBytesWritten"];
    [self setRusumeValue:@(_totalBytesExpectedToWrite) forKey:@"totalBytesExpectedToWrite"];
}


// MARK - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"%s", __func__);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    _totalBytesWritten = totalBytesWritten;
    _totalBytesExpectedToWrite = totalBytesExpectedToWrite;
    
    float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.didWriteLabel.text = [NSString stringWithFormat:@"%0.3fM", totalBytesWritten / 1024.0 / 1024.0];;
        self.totalBytesLabel.text = [NSString stringWithFormat:@"%0.3fM", totalBytesExpectedToWrite / 1024.0 / 1024.0];
        
        [self.progressView setProgress:progress animated:YES];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"%s", __func__);
}

- (IBAction)didClickStart:(id)sender {
    if (self.downTask.state == NSURLSessionTaskStateSuspended) {
        [self.downTask resume];
        return;
    }
    NSLog(@"%@===%p", self.downTask, self.downTask);
    self.downTask = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.downTask resume];
    NSLog(@"%@===%p", self.downTask, self.downTask);
    
}

- (IBAction)didClickSuspend:(id)sender {
   if (self.downTask.state == NSURLSessionTaskStateCompleted) {
       [self show:nil message:@"任务已经完成，不能再取消了"];
       return;
    }
    
    [self.downTask suspend];
//    [self show:nil message:@"任务已暂停"];
}

- (IBAction)didClickCancel:(id)sender {
    if (self.downTask.state == NSURLSessionTaskStateCompleted) {
        [self show:nil message:@"任务已经完成，不能再取消了"];
        return;
    }
    
//    [self.downTask cancel];
    __weak typeof(self) weakSelf = self;
    [_downTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        weakSelf.resumeData = resumeData;
        [resumeData writeToFile:weakSelf.rusumePath atomically:YES];
        float size = resumeData.length / 1024.0 / 1024.0;
        NSLog(@"total = %0.3f M", size);
    }];
//    [self show:nil message:@"任务已取消"];
}

- (void)show:(NSString *)title message:(NSString *)message {
    if (title.length <= 0) {
        title = @"提示";
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
