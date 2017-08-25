//
//  WebImageController.m
//  NSURLSession
//
//  Created by Silent on 2017/7/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "WebImageController.h"
#import "WebImageCell.h"

static NSString * const kWebImageCell = @"WebImageCell";

@interface WebImageController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;
@end
@implementation WebImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject);
}

// MARK - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WebImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kWebImageCell];
    NSString *string = self.dataList[indexPath.row];
    UIImage *placeHolder = [UIImage imageNamed:@"image_02"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:placeHolder];
    return cell;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        NSArray *temp;
        temp = @[@"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230244589292522.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230246183963326.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230246216418640.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230247046812269.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230247027154317.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230247316079809.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230248455046881.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230248475015586.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230249152227260.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230251243285077.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230251271209828.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230251498976041.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230251520968976.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230252065119873.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230252205356695.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230252211434027.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230252535296333.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230252555108266.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230252536544859.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230253344633266.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230253345888282.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230253551654473.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230253572556907.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230253578952483.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230254293605768.jpg",
        @"http://tcw-public.b0.upaiyun.com//youji/2015-11-23-201511230254324176535.jpg"];
        _dataList = temp.mutableCopy;

    }
    return _dataList;
}
@end
