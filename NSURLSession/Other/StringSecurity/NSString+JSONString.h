//
//  NSString+JSONString.h
//  NSDictoryToString
//
//  Created by Silence on
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSONString)

+ (NSString *)jsonStringOfObject:(id)object;
+ (NSString *)jsonStringDictionary:(NSDictionary *)object;

@end
