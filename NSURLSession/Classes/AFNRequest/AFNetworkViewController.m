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

/** ZHS */
- (void)laodingRequestWithZHS {
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfig setHTTPAdditionalHeaders:@{@"User-Agent" : @"ios"}];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfig];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // curr
    NSMutableDictionary *curr = [NSMutableDictionary dictionary];
    
    [curr setObject:@(210565601) forKey:@"child_id"];
    [curr setObject:@(202449672) forKey:@"class_id"];
    [curr setObject:@(202032240) forKey:@"school_id"];
    [curr setObject:@(212616083) forKey:@"user_id"];
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
    [parameters setObject:@(212616083) forKey:@"toUserId"];
    
//    [parameters setObject:@(1) forKey:@"type"];
    [parameters setObject:@"6043c13b895775edd125a6028032cb19" forKey:@"uuid"];
//    [parameters setObject:@"{\n\"createTime\" : -1\n}" forKey:@"order"];
//    [parameters setObject:@(1) forKey:@"pageNo"];
//    [parameters setObject:@(10) forKey:@"pageSize"];
    
    // parameters =>> 转成String =>> AES加密（加密key: 5ac353af8aaf0906） =>> bsse 64 加密
    NSString *parameterString = @"";
    NSString *tempString = [NSString jsonStringWithDictionary:parameters];
    tempString = [tempString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSData *parameterData = [tempString dataUsingEncoding:NSUTF8StringEncoding];
    parameterData = [parameterData AES128DecryptWithKey:@"83b197bff804d747"];
    parameterData = [parameterData base64];
    parameterString = [[NSString alloc] initWithData:parameterData encoding:NSUTF8StringEncoding];
    parameterString = @"Yl5jE1Wf0675vVPmuVElQdPtk1TgOSeAK1FkM1s/6YnvSJC/LSzMb0yxpR4dQbI+hH7fqIsOt9KhWilbHEkckH5Cj+Z004ULQ/H5Q52BSAoNt/zPBDIYS+v/sexNXavbmBK3gap9AHIv8/JzHwhFZylQ61M+IYCCqthHFAdthN3Wx4WQOpyzIHvop0Jlq3HxlNtI4xpf6o1SAa6bNHqmzjbycWBI9dNtaZHa1ML9yjFilQhVTquH0B0RcFUtsdk3k3+L9eM0Grejw86zBJ7ikiO3AIVtr/9sLM9s2tEuamAdnjnyJ7GST8Nh5Q9MX4GPejpDcU8xxGmMr5ntYRx07Z9HZIJimTTHupqpTCzsmJSTbzjU3XC6hiegAI2gjvGyO9Rq0Djsa3Yi+AKT/hngfM82cXHvJ62GKikcwz2GmQrXVb3Vif9k/Dx2nW7gY2K8r56tQyOcyHT5aPozYUe9V72rLcedHqSb7/vwNhPX746Y4OZaQnHN06BiP07tzP7XrPh+qGnq0qpKNJQ9BeOHH+WIJDcOeR2x5KW6qYuDPOHt79Un0w2Rn9dPyMiCu8yR";
    // data
    NSMutableDictionary *dataParameter = [NSMutableDictionary dictionary];
    [dataParameter setObject:parameterString forKey:@"data"];
    [dataParameter setObject:@(41) forKey:@"data_ver"];
    [dataParameter setObject:@"1" forKey:@"ios_arm64_flag"];
    [dataParameter setObject:@"6043c13b895775edd125a6028032cb19" forKey:@"uuid"];
    
    NSString *URLString = @"https://javaport.bbtree.com/public/bizmsg/noreadnums";
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:dataParameter error:NULL];
    
    [request setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.responseSerializer = responseSerializer;
    
    AFHTTPSessionManager *managerH = [AFHTTPSessionManager manager];
    managerH.responseSerializer = responseSerializer;
    managerH.requestSerializer = [AFJSONRequestSerializer serializer];
    [managerH.requestSerializer setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    
    [managerH POST:URLString parameters:dataParameter progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@", uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        
    }];
    return;
    
    
    /*
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }else {
            NSLog(@"请求成功了");
        }
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", string);
        
        
    }];
    [task resume];
    */
    
}
@end

//@implementation AFJSONRequestSerializer
//
//+ (instancetype)serializer {
//    return [self serializerWithWritingOptions:(NSJSONWritingOptions)0];
//}
//
//+ (instancetype)serializerWithWritingOptions:(NSJSONWritingOptions)writingOptions {
//    AFJSONRequestSerializer *serializer = [[self alloc] init];
//    serializer.writingOptions = writingOptions;
//    return serializer;
//}
//@end
/*
 {
 curr =     {
     "child_id" = 103611435;
     "class_id" = 100187260;
     "school_id" = 100035119;
     "user_id" = 105346878;
 };
 
 "data_ver" = 41;
 "device_no" = iPhone;
 "mobile_system" = "iOS 10.3.3";
 order = "{\n  \"createTime\" : -1\n}";
 pageNo = 1;
 pageSize = 10;
 platform = 1;
 
 sa =     {
     "$app_version" = "P_Build_6.4.4";
     "$model" = iPhone;
     "$network_type" = WIFI;
     "$os" = iOS;
     "$os_version" = "iOS 10.3.3";
 };
 
 "school_app_type" = 0;
 toUserId = 105346878;
 type = 1;
 uuid = 6043c13b895775edd125a6028032cb19;
 "version_code" = 644;
 "version_no" = "P_Build_6.4.4";
 }
 */

/*
 {
 data = "";
 "data_ver" = 41;
 "ios_arm64_flag" = 1;
 uuid = 6043c13b895775edd125a6028032cb19;
 }
 */



