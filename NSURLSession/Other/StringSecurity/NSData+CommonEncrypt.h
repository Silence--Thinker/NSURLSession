//
//  NSData+CommonEncrypt.h
//  NSURLSession
//
//  Created by Silence on 2017/8/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CommonEncrypt)

#pragma mark - BASE64
/** 加密为base64 */
- (NSData *)base64;
/** 解密base64 */
- (NSData *)base64Decode;


#pragma mark - AES-128
/** AES-128 加密 无初始向量 */
- (NSData *)AES128EncryptWithKey:(NSString *)key;
/** AES-128 解密 无初始向量 */
- (NSData *)AES128DecryptWithKey:(NSString *)key;

/** AES-128 加密 有初始向量 */
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;
/** AES-128 解密 有初始向量 */
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;

/** AES-256 加密 有初始向量 */
- (NSData *)AES256EncryptWithKey:(NSString *)key;
/** AES-256 解密 有初始向量 */
- (NSData *)AES256DecryptWithKey:(NSString *)key;
@end
