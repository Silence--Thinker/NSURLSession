//
//  AFNetworkViewController.m
//  NSURLSession
//
//  Created by Silence on 2017/8/28.
//  Copyright © 2017年 Silence. All rights reserved.
//
//  @"http://www.kuaidi100.com/query?type=yuantong&postid=11111111111"

#import "AFNetworkViewController.h"
#import <AFNetworking/AFURLRequestSerialization.h>

#import "ResponseCircleInfo.h"
#import "TransformModel.h"

@interface AFNetworkViewController ()


@end
@implementation AFNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self loadingInfo];
//    [self laodingRequestWithTC];
    [self laodingRequestWithZHS];
}

- (void)loadingInfo {
    
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    NSMutableSet *setM = httpManager.responseSerializer.acceptableContentTypes.mutableCopy;
    [setM addObject:@"text/html"];
    httpManager.responseSerializer.acceptableContentTypes = setM;
    NSString *URLString = @"http://www.kuaidi100.com/query?type=yuantong&postid=11111111111";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"d56cf2afbc1fb55b580df069758dc733f817ac84|414*736|iPhone8,2"
                   forKey:@"device"];
    [parameters setObject:@"010cb28b53a179a53f1a9a34d423f26387f704334aa0" forKey:@"clientId"];
    [parameters setObject:@"d280b487b9af6f413496534b5391e777" forKey:@"mac"];
    
    [httpManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"progress == %0.3f", (float)uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success == %@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure == %@", error);
    }];
}

/** TC 失败告终 */
- (void)laodingRequestWithTC {
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    // header
    NSMutableDictionary *headerValueDict = [NSMutableDictionary dictionary];
    [headerValueDict setObject:@"5ee7b429-b8c6-400f-8b87-3c384c4ea68a" forKey:@"accountID"];
    [headerValueDict setObject:@"getdaybestlist" forKey:@"serviceName"];
    [headerValueDict setObject:@"1503908120762" forKey:@"reqTime"];
    [headerValueDict setObject:@"0a56b30f51b12982a66e92a845ceef5a" forKey:@"digitalSign"];
    [headerValueDict setObject:@"20110303090115" forKey:@"version"];
    
    for (NSString * httpHeaderField in headerValueDict.allKeys) {
        NSString *value = headerValueDict[httpHeaderField];
        [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
    }
//    [requestSerializer setValue:@"TongchengRequest" forHTTPHeaderField:@"User-Agent"];
    httpManager.requestSerializer = requestSerializer;
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"d56cf2afbc1fb55b580df069758dc733f817ac84|414*736|iPhone8,2"
                   forKey:@"device"];
    [parameters setObject:@"010cb28b53a179a53f1a9a34d423f26387f704334aa0" forKey:@"clientId"];
    [parameters setObject:@"d280b487b9af6f413496534b5391e777" forKey:@"mac"];
    [parameters setObject:@"10.0.9.81" forKey:@"clientIp"];
    [parameters setObject:@"iPhone" forKey:@"versionType"];
    [parameters setObject:@"1|3|53" forKey:@"area"];
    [parameters setObject:@"d56cf2afbc1fb55b580df069758dc733f817ac84" forKey:@"deviceId"];
    [parameters setObject:@"wifi" forKey:@"networkType"];
    [parameters setObject:@"|^53^53^1^53^0^|" forKey:@"tag"];
    [parameters setObject:@"" forKey:@"pushInfo"];
    [parameters setObject:@"2^com.tongcheng.iphone,4^10.3.3,5^iPhone8_2" forKey:@"extend"];
    [parameters setObject:@"5866741" forKey:@"refId"];
    [parameters setObject:@"tc" forKey:@"systemCode"];
    [parameters setObject:@"8.3.5" forKey:@"versionNumber"];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:parameters forKey:@"clientInfo"];
    [dict setObject:@"1" forKey:@"searchType"];
    [dict setObject:@"1" forKey:@"pageIndex"];
    
//    NSMutableDictionary *body = [NSMutableDictionary dictionary];
//    [body setObject:dict forKey:@"body"];
//    [body setObject:headerValueDict forKey:@"header"];
    
    
    NSString *URLString = @"https://tcmobileapi.17usoft.com/youji/youjiresource.ashx";
    [httpManager POST:URLString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"progress == %0.3f", (float)uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success == %@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure == %@", error);
    }];
}

/** ZHS  成功 */
- (void)laodingRequestWithZHS {
    /*
     每个设备的加密串不一样: a634e8a8e63aac0cdda20c51324195fc  key: 60a4619790c2b258
     */
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfig setHTTPAdditionalHeaders:@{@"User-Agent" : @"ios"}];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfig];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // curr
    NSMutableDictionary *curr = [NSMutableDictionary dictionary];
    
    [curr setObject:@(217667186) forKey:@"child_id"];
    [curr setObject:@(202788208) forKey:@"class_id"];
    [curr setObject:@(4833) forKey:@"school_id"];
    [curr setObject:@(221280298) forKey:@"user_id"];
    [parameters setObject:curr forKey:@"curr"];
    
    // sa
    NSMutableDictionary *sa = [NSMutableDictionary dictionary];
    [sa setObject:@"P_Build_6.4.4" forKey:@"$app_version"];
    [sa setObject:@"iPhone" forKey:@"$model"];
    [sa setObject:@"WIFI" forKey:@"$network_type"];
    [sa setObject:@"iOS" forKey:@"$os"];
    [sa setObject:@"iOS 10.3.3" forKey:@"$os_version"];
    [parameters setObject:sa forKey:@"sa"];
    
    // other
    [parameters setObject:@(0) forKey:@"school_app_type"];
    [parameters setObject:@(41) forKey:@"data_ver"];
    [parameters setObject:@(1) forKey:@"platform"];
    [parameters setObject:@"664" forKey:@"version_code"];
    [parameters setObject:@"iPhone" forKey:@"device_no"];
    [parameters setObject:@"iOS 10.3.3" forKey:@"mobile_system"];
    [parameters setObject:@"P_Build_6.4.4" forKey:@"version_no"];
    
    // current parameter
//    [parameters setObject:@(221280298) forKey:@"toUserId"];
//    [parameters setObject:@(1) forKey:@"type"];
//    [parameters setObject:@"6043c13b895775edd125a6028032cb19" forKey:@"uuid"];
//    [parameters setObject:@"{\n\"createTime\" : -1\n}" forKey:@"order"];
    [parameters setObject:@(1) forKey:@"pageNo"];
    [parameters setObject:@(20) forKey:@"pageSize"];
    
    // parameters =>> 转成String =>> AES加密（加密key: 5ac353af8aaf0906） =>> bsse 64 加密
    
    NSString *parameterString = @"";
    NSString *tempString = [NSString jsonStringOfObject:parameters];
    tempString = [tempString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSData *parameterData = [tempString dataUsingEncoding:NSUTF8StringEncoding];
    parameterData = [parameterData AES256EncryptWithKey:@"60a4619790c2b258"];
    parameterData = [parameterData base64];
    parameterString = [[NSString alloc] initWithData:parameterData encoding:NSUTF8StringEncoding];
    
    NSData *responseData = [parameterString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [responseData base64Decode];
    NSData *tempData = [data AES256DecryptWithKey:@"60a4619790c2b258"];
    NSString *stringRe = [[NSString alloc] initWithData:tempData encoding:NSUTF8StringEncoding];
    
    NSLog(@"success%@", stringRe);
    
    // data
    NSMutableDictionary *dataParameter = [NSMutableDictionary dictionary];
    [dataParameter setObject:parameterString forKey:@"data"];
    [dataParameter setObject:@(41) forKey:@"data_ver"];
    [dataParameter setObject:@"1" forKey:@"ios_arm64_flag"];
    [dataParameter setObject:@"a634e8a8e63aac0cdda20c51324195fc" forKey:@"uuid"];
    
    // member/classstar/getCardInfo
    // circle_v7/circle/my/list
    // public/bizmsg/noreadnums
    NSString *URLString = @"https://javaport.bbtree.com/circle_v7/circle/my/list";
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:dataParameter error:NULL];
    
    [request setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    [AFJSONResponseSerializer serializer];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.responseSerializer = responseSerializer;
    
    AFHTTPSessionManager *managerH = [AFHTTPSessionManager manager];
    managerH.responseSerializer = responseSerializer;
    managerH.requestSerializer = [AFJSONRequestSerializer serializer];
    [managerH.requestSerializer setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    
    /*
    [managerH POST:URLString parameters:dataParameter progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@", uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSData *responseData = (NSData *)responseObject;
     
        NSData *data = [responseData base64Decode];
        NSData *tempData = [data AES256DecryptWithKey:@"60a4619790c2b258"];
        NSString *stringRe = [[NSString alloc] initWithData:tempData encoding:NSUTF8StringEncoding];
        
        NSLog(@"success%@", stringRe);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        
    }];
    return;
    */
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }else {
            NSLog(@"请求成功了");
        }
        
        NSData *responseData = (NSData *)responseObject;
        NSData *data = [responseData base64Decode];
        NSData *tempData = [data AES256DecryptWithKey:@"60a4619790c2b258"];
        NSString *stringRe = [[NSString alloc] initWithData:tempData encoding:NSUTF8StringEncoding];
        
        NSData *jsonData = [stringRe dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *responseDcit = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:NULL];
        NSLog(@"%@", responseDcit);

        NSArray *array = [responseDcit objectForKey:@"data"];
        if (array.count) {
            ResponseCircleInfo *circleInfo = [ResponseCircleInfo transformModelWith:array[0]];
            
            NSLog(@"%@", circleInfo.circle_user_nick);
        }
    }];
    [task resume];
    
    
}

@end
