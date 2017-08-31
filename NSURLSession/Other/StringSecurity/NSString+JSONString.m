//
//  NSString+JSONString.m
//  NSDictoryToString
//
//  Created by Silence
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "NSString+JSONString.h"

@implementation NSString (JSONString)

+ (NSString *)jsonStringNumber:(NSNumber *)number {
    if (!number) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@", number];
}

+ (NSString *)jsonStringString:(NSString *)string {
    return [NSString stringWithFormat:@"\"%@\"", string];
}

+ (NSString *)jsonStringDictionary:(NSDictionary *)object {
    NSMutableString *stringM = [NSMutableString string];
    if (!object) {
        return stringM;
    }
    [stringM appendString:@"{"];
    
    NSArray *keysArray = object.allKeys;
    NSInteger count = keysArray.count;
    for (NSInteger i = 0 ; i < count; i++) {
        id key = keysArray[i];
        id value = object[key];
        NSString *valueString = [self jsonStringOfObject:value];
        NSString *keyString = [self jsonStringOfObject:key];
        
        NSString *tempString =  [NSString stringWithFormat:@"%@: %@", keyString, valueString];
        [stringM appendString:tempString];
        if (i != count -1) {
            [stringM appendString:@","];
        }
    }
    [stringM appendString:@"}"];
    return stringM;
}

+ (NSString *)jsonStringArray:(NSArray *)object {
    NSMutableString *stringM = [NSMutableString string];
    if (!object) {
        return stringM;
    }
    [stringM appendString:@"["];
    NSInteger count = object.count;
    
    for (NSInteger i = 0 ; i < count; i++) {
        id value = object[i];
        NSString *valueString = [self jsonStringOfObject:value];
        [stringM appendString:valueString];
        if (i != count - 1) {
            [stringM appendString:@","];
        }
    }
    
    [stringM appendString:@"]"];
    return stringM;
}

+ (NSString *)jsonStringOfObject:(id)object {
    if (!object) {
        return @"";
    }
    if ([object isKindOfClass:[NSString class]]) {
        return [self jsonStringString:object];
        
    }else if ([object isKindOfClass:[NSNumber class]]) {
        return [self jsonStringNumber:object];
        
    }else if ([object isKindOfClass:[NSDictionary class]]) {
        return [self jsonStringDictionary:object];
    }else if ([object isKindOfClass:[NSArray class]]) {
        return [self jsonStringArray:object];
    }
    return @"";
}

+ (NSString *)retractOfObject:(id)object {
    if ([object isKindOfClass:[NSString class]]) {
        return @"";
    }else if ([object isKindOfClass:[NSNumber class]]) {
        return @"";
        
    }else if ([object isKindOfClass:[NSDictionary class]]) {
        return @"\t";
    }
    return nil;
}
@end
