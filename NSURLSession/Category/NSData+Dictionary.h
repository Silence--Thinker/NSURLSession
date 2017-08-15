//
//  NSData+Dictionary.h
//  NSURLSession
//
//  Created by Silent on 2017/4/24.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Dictionary)

+ (instancetype)dataWithDictionary:(NSDictionary *)dict;

- (NSDictionary *)jsonData2Dictionary;

@end
