//
//  TransformModel.m
//  NSURLSession
//
//  Created by Silence on 2017/8/31.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "TransformModel.h"
#import <objc/runtime.h>


@implementation TransformModel



@end


@implementation NSObject (TransformModel)

+ (instancetype)transformModelWith:(NSDictionary *)object {

//    ResponseCircleInfo
    
    NSString *className = NSStringFromClass([self class]);
    if (![className hasPrefix:@"Response"]) {
        NSAssert(NO, @"请检查，响应类名必须是以 “Response” 开头");
        return nil;
    }
    
    id model = [[self alloc] init];
    Class class = object_getClass(model);
    unsigned int propertyCount = 0;
    
    objc_property_t *propertyList = class_copyPropertyList(class, &propertyCount);
    
    
    for (unsigned int i = 0; i < propertyCount; i++) {
        
        objc_property_attribute_t *attribute = property_copyAttributeList(*propertyList, &i);
        NSLog(@"%s", property_getName(*propertyList));
        
        propertyList++;
    }
    
    return nil;
}

- (void)ssss {
    
}

@end
