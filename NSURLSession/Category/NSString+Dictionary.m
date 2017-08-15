//
//  NSString+Dictionary.m
//  NSURLSession
//
//  Created by Silent on 2017/4/24.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "NSString+Dictionary.h"

@implementation NSString (Dictionary)

- (NSDictionary *)jsonString2Dictionary {
    NSError *error = NULL;
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dictM = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return nil;
    }
    return dictM;
}

@end
