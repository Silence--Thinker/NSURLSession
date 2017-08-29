//
//  NSData+CommonEncrypt.m
//  NSURLSession
//
//  Created by Silence on 2017/8/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "NSData+CommonEncrypt.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (CommonEncrypt)

- (NSData *)base64 {
    return [self base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

- (NSData *)base64Decode {
    return [[NSData alloc] initWithBase64EncodedData:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

// 加密
- (NSData *)AES128EncryptWithKey:(NSString *)key {
    return [self AES128operation:kCCEncrypt key:key];
}

// 解密
- (NSData *)AES128DecryptWithKey:(NSString *)key {
    return [self AES128operation:kCCDecrypt key:key];
}

//加密
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv {
    return [self AES128operation:kCCEncrypt key:key iv:iv];
}

//解密
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv {
    return [self AES128operation:kCCDecrypt key:key iv:iv];
}

- (NSData *)AES128operation:(CCOperation)operation key:(NSString *)key {
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [self length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;

    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            NULL,
                                            [self bytes], [self length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess){
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)AES128operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv {
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [self length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [self bytes], [self length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess){
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

@end
