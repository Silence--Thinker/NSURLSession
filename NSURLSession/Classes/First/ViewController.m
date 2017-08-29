//
//  ViewController.m
//  NSURLSession
//
//  Created by Silent on 2017/4/11.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "XJDownloadTaskController.h"

static NSString * const kTableViewCell = @"UITableViewCellClass";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCell];
    
    [self buildingDataListCompletion:^(NSMutableArray *arrayM) {
        self.dataList = arrayM;
        [self.tableView reloadData];
    }];
}

// URLSession GET请求 NSURLSessionDataTask Block
- (void)URLSessionDemo01 {
    NSURLSession *sesstion = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"https://g1.163.com/preloadimg?app=7A16FBB6&platform=ios&netstat=1"];
    NSURLSessionDataTask *dataTask = [sesstion dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
        
        NSLog(@"%@", response);
        NSDictionary *dictM = [data jsonData2Dictionary];
        NSLog(@"%@", dictM);
    }];
    [dataTask resume];
}

// URLSession POST请求 NSURLSessionDataTask Block
- (void)URLSessionDemo02 {
    NSURL *url = [NSURL URLWithString:@"https://mobileapi.ly.com/youji/lighttravelresource.ashx"];
    NSMutableDictionary *requestDictM = [NSMutableDictionary dictionary];
    NSMutableDictionary *bodyDictM = [NSMutableDictionary dictionary];
    NSMutableDictionary *headerDictM = [NSMutableDictionary dictionary];
    NSMutableDictionary *clientDictM = [NSMutableDictionary dictionary];
    
    [clientDictM setObject:@"93FB1A96-5778-4792-A50C-9EF6D973C8C4" forKey:@"deviceId"];
    [clientDictM setObject:@"2^com.tongcheng.strategy,4^10.3.1,5^iPhone8_2" forKey:@"extend"];
    [clientDictM setObject:@"254e483f4615fa582d98b6f655fb3564" forKey:@"mac"];
    [clientDictM setObject:@"93FB1A96-5778-4792-A50C-9EF6D973C8C4|414*736|iPhone8,2" forKey:@"device"];
    [clientDictM setObject:@"wifi" forKey:@"networkType"];
    [clientDictM setObject:@"180328290" forKey:@"refId"];
    [clientDictM setObject:@"6e67a951bb4810e6ca47a195f0486e95a246638c2100" forKey:@"clientId"];
    [clientDictM setObject:@"iPhone" forKey:@"versionType"];
    [clientDictM setObject:@"192.168.2.90" forKey:@"clientIp"];
    [clientDictM setObject:@"travel" forKey:@"systemCode"];
    [clientDictM setObject:@"8.1.0" forKey:@"versionNumber"];
    
    [bodyDictM setObject:@"325292" forKey:@"lightTravelId"];
    [bodyDictM setObject:@"42" forKey:@"projectId"];
    [bodyDictM setObject:@"I0_ae0303eff31ead119bcc63228196c5f4" forKey:@"curLoginMemberId"];
    [bodyDictM setObject:clientDictM forKey:@"clientInfo"];
    
    [headerDictM setObject:@"5ee7b429-b8c6-400f-8b87-3c384c4ea68a" forKey:@"accountID"];
    [headerDictM setObject:@"0" forKey:@"encryptEffort"];
    [headerDictM setObject:@"gettraveldetail" forKey:@"serviceName"];
    [headerDictM setObject:@"1493022293668" forKey:@"reqTime"];
    [headerDictM setObject:@"292dcefa51e7b8144925e97516e1cf2a" forKey:@"digitalSign"];
    [headerDictM setObject:@"20110303090115" forKey:@"version"];
    
    [requestDictM setObject:bodyDictM forKey:@"body"];
    [requestDictM setObject:headerDictM forKey:@"header"];
    
//    dictM
    NSData *bodyData = [NSData dataWithDictionary:@{@"request":requestDictM}];

    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = bodyData;
    
//    request
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error);
        }
        NSLog(@"%@", response);
        NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", jsonStr);
    }];
    [task resume];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self URLSessionDemo01];
//    [self URLSessionDemo02];
}

// MARK - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCell];
    
    NSDictionary *dict = self.dataList[indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataList[indexPath.row];
    Class class = NSClassFromString([dict objectForKey:@"class"]);
    UIViewController *vc = [[class alloc] init];
//    XJDownloadTaskController *vc = [[XJDownloadTaskController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)buildingDataListCompletion:(void(^)(NSMutableArray *arrayM))completion {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dataList" ofType:@"plist"];
    
    NSMutableArray *arryM;
    arryM = [NSArray arrayWithContentsOfFile:path].mutableCopy;
    completion(arryM);
}

@end
