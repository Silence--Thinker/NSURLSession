//
//  XJSessionDataTaskController.m
//  NSURLSession
//
//  Created by XJC on 2017/8/27.
//  Copyright © 2017年 Silence. All rights reserved.
//
//  http://sw.bos.baidu.com/sw-search-sp/software/9629a8d93b17f/teamviewer_11.0.65280.dmg
//  https://download.developer.apple.com/Developer_Tools/Xcode_8.2/Xcode_8.2.xip
//  magnet:?xt=urn:btih:A18B93D3EE84BAB819A4E51B4B58FA546E13D953

#import "XJSessionDataTaskController.h"

static NSString * const kResumeInfoPath = @"dataTaskResumeInfo.plist";
static NSString * const CurrentBytes = @"currentBytes";
static NSString * const TotalBytes = @"totalBytes";

@interface XJSessionDataTaskController ()
<NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;

@property (nonatomic, weak) IBOutlet UILabel *totalBytesLabel;
@property (nonatomic, weak) IBOutlet UILabel *didWriteLabel;

// URLSession
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, strong) NSFileHandle *handle;
@property (nonatomic, strong) NSOutputStream *stream;

@end
@implementation XJSessionDataTaskController {
    int64_t _currentBytes;         // 已经下载数据大小
    int64_t _totalBytes;           // 文件总大小
    NSString *_URLString;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.text =  @"http://sw.bos.baidu.com/sw-search-sp/software/9629a8d93b17f/teamviewer_11.0.65280.dmg";
    [self initialzeDownloadTaskVariablesValue];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.session invalidateAndCancel];
}

- (void)initialzeDownloadTaskVariablesValue {
    
    // sessionConfig
    _sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // session
    _session = [NSURLSession sessionWithConfiguration:_sessionConfig delegate:self delegateQueue:[NSOperationQueue new]];
    
    // request
    _request = [self currentRequest];
    
    // dataTask
    self.dataTask = [self.session dataTaskWithRequest:_request];
    
    // 进度
    if (_totalBytes) {
        self.didWriteLabel.text = [NSString stringWithFormat:@"%0.3fM", _currentBytes / 1024.0 / 1024.0];;
        self.totalBytesLabel.text = [NSString stringWithFormat:@"%0.3fM", _totalBytes / 1024.0 / 1024.0];
        float progress = (float)_currentBytes / _totalBytes * 1.0;
        [self.progressView setProgress:progress animated:NO];
    }
}

- (NSMutableURLRequest *)currentRequest {
    NSString *string = self.textField.text;
//    string = @"https://github.com/MacDownApp/macdown/releases/download/v0.7.1/MacDown.app.zip";
    NSURL *url = [NSURL URLWithString:string];
    
    NSString *currenKey =  [NSString stringWithFormat:@"%@_%@",url.absoluteString, CurrentBytes];
    NSString *totalKey = [NSString stringWithFormat:@"%@_%@",url.absoluteString, TotalBytes];
    _URLString = url.absoluteString;
    
    // 获取之前下载的进度
    _currentBytes = [[self rusumeValueForKey:currenKey] integerValue];
    _totalBytes = [[self rusumeValueForKey:totalKey] integerValue];
    
    _request = [NSMutableURLRequest requestWithURL:url];
    
    if (_totalBytes) {
        NSInteger currentSize = _currentBytes;
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-", currentSize];
        [_request setValue:range forHTTPHeaderField:@"Range"];
    }
    _request.timeoutInterval = 5;
    return _request;
}

- (NSString *)resumeInfoPath {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [documentPath stringByAppendingPathComponent:kResumeInfoPath];
    return path;
}

- (void)setRusumeValue:(id)value forKey:(id <NSCopying>)key {
    
    NSString *path = self.resumeInfoPath;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
    }
    [dict setObject:value forKey:key];
    [dict writeToFile:path atomically:YES];
}

- (id)rusumeValueForKey:(id <NSCopying>)key {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:self.resumeInfoPath];
    if (!dict) {
        return nil;
    }
    id value = [dict objectForKey:key];
    return value;
}

- (NSString *)fileFullPath:(NSString *)lastName {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *file = [documentPath stringByAppendingPathComponent:lastName];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager isExecutableFileAtPath:file]) {
        BOOL result = [manager createDirectoryAtPath:file withIntermediateDirectories:YES attributes:nil error:NULL];
        if (result == NO) {
            return nil;
        }
    }
    
    NSString *path = [file stringByAppendingPathComponent:lastName];
    return path;
}

// MARK - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"%s", __func__);
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"%s", __func__);
    
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    //判断服务器返回的证书是否是服务器信任的
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        /*disposition：如何处理证书
         NSURLSessionAuthChallengePerformDefaultHandling:默认方式处理
         NSURLSessionAuthChallengeUseCredential：使用指定的证书    NSURLSessionAuthChallengeCancelAuthenticationChallenge：取消请求
         */
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
    }
    //安装证书
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
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
    
    completionHandler(request);
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
    [self show:nil message:@"下载完成"];
    
    NSString *currenKey =  [NSString stringWithFormat:@"%@_%@",_URLString, CurrentBytes];
    NSString *totalKey = [NSString stringWithFormat:@"%@_%@",_URLString, TotalBytes];
    
    [self setRusumeValue:@(_currentBytes) forKey:currenKey];
    [self setRusumeValue:@(_totalBytes) forKey:totalKey];
    
    /*
    // 文件写入方式
    [self.handle closeFile];
    self.handle = nil;
    */
    
    // 数据流写入的方式
    [self.stream close];
    self.stream = nil;
}


// MARK - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"%s", __func__);
    
    // 总大小 断点时候request的Range可能改变
    _totalBytes = response.expectedContentLength + _currentBytes;
    
    //  文件路径
    NSString *path = [self fileFullPath:_URLString.lastPathComponent];

    /*
     // 文件写入方式
    if (_currentBytes <= 0) {
        BOOL succeed = [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
        if (succeed == NO) {
            completionHandler(NSURLSessionResponseCancel);
            return;
        }
    }
    
    self.handle = [NSFileHandle fileHandleForWritingAtPath:path];
    [self.handle seekToEndOfFile];
    */
    
    // 数据流写入的方式
    NSOutputStream *stream = [[NSOutputStream alloc] initWithURL:[NSURL fileURLWithPath:path] append:YES];
    [stream open];
    self.stream = stream;
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    NSLog(@"%s", __func__);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask {
    NSLog(@"%s", __func__);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    /*
     // 文件写入方式
    [self.handle writeData:data];
    */
    
    // 数据流写入的方式
    [self.stream write:data.bytes maxLength:data.length];
    
    // 更新进度
    _currentBytes += data.length;
    dispatch_async(dispatch_get_main_queue(), ^{
    
        self.didWriteLabel.text = [NSString stringWithFormat:@"%0.3fM", _currentBytes / 1024.0 / 1024.0];
        self.totalBytesLabel.text = [NSString stringWithFormat:@"%0.3fM", _totalBytes / 1024.0 / 1024.0];
        
        float progress = (float)_currentBytes / _totalBytes * 1.0;
        [self.progressView setProgress:progress animated:YES];
        
    });
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler {
    NSLog(@"%s", __func__);
}

- (IBAction)didClickStart:(id)sender {
    if (self.dataTask.state == NSURLSessionTaskStateRunning) {
        return;
    }
    [self.dataTask resume];
    return;
}

- (IBAction)didClickSuspend:(id)sender {
    if (self.dataTask.state == NSURLSessionTaskStateCompleted) {
        [self show:nil message:@"任务已经完成，不能暂停"];
        return;
    }
    
    [self.dataTask suspend];
}

- (IBAction)didClickCancel:(id)sender {
    if (self.dataTask.state == NSURLSessionTaskStateCompleted) {
        [self show:nil message:@"任务已经完成，不能再取消了"];
        return;
    }
    [self.dataTask cancel];
}

- (IBAction)changeRequest:(id)sender {
    [self currentRequest];
    self.dataTask = [self.session dataTaskWithRequest:_request];
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
