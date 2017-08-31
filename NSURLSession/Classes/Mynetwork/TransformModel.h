//
//  TransformModel.h
//  NSURLSession
//
//  Created by Silence on 2017/8/31.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransformModel : NSObject


@end


@interface NSObject (TransformModel)

+ (instancetype)transformModelWith:(NSDictionary *)object;

@end
