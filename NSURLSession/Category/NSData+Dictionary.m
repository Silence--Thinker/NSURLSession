//
//  NSData+Dictionary.m
//  NSURLSession
//
//  Created by Silent on 2017/4/24.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "NSData+Dictionary.h"

@implementation NSData (Dictionary)

+ (instancetype)dataWithDictionary:(NSDictionary *)dict {
    NSError *error = NULL;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return nil;
    }
    return data;
}

- (NSDictionary *)jsonData2Dictionary {
    NSError *error = NULL;
    NSDictionary *dictM = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    return dictM;
}
@end
