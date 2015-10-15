//
//  Crypto.h
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Crypto : NSObject

#pragma mark - Class Methods

+ (NSString *)generateRandomString;

+ (NSString *)hexEncode:(NSString *)string;
+ (NSData *)hexDecode:(NSString *)hexString;

+ (NSData *)sha256HMAC:(NSData *)data withKey:(NSString *)key;

+ (NSData *)AES128Decrypt:(NSData *)data key:(NSData *)key withIV:(NSData *)iv;
+ (NSData *)decrypt:(NSString *)data key:(NSString *)key;

+ (NSString *)SHA256encrypt:(NSString *)string;

@end
