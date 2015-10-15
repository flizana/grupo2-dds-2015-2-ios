//
//  Crypto.m
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "Crypto.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>

@implementation Crypto

+ (NSString *)generateRandomString
{
    unichar random[16];
    SecRandomCopyBytes(kSecRandomDefault, 16, (uint8_t *)&random);
    NSString *base = [NSString stringWithCharacters:random length:16];
    return [[Crypto hexEncode:base] substringToIndex:32];
}

+ (NSString *)hexEncode:(NSString *)string
{
    unichar *chars = malloc(string.length * sizeof(unichar));
    [string getCharacters:chars];
    
    NSMutableString *hexString = [NSMutableString string];
    for (NSUInteger i = 0; i < string.length; i++){
        if ((int)chars[i] < 16){
            [hexString appendString:@"0"];
        }
        [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
    }
    free(chars);
    return hexString;
}

+ (NSData *)hexDecode:(NSString *)hexString
{
    NSMutableData *stringData = [NSMutableData data];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0', '\0', '\0'};
    int i;
    for (i = 0; i < hexString.length / 2; i++){
        byte_chars[0] = [hexString characterAtIndex:i * 2];
        byte_chars[1] = [hexString characterAtIndex:i * 2 + 1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [stringData appendBytes:&whole_byte length:1];
    }
    return stringData;
}

+ (NSData *)sha256HMAC:(NSData *)data withKey:(NSString *)key
{
    CCHmacContext context;
    const char *keyCString = [key cStringUsingEncoding:NSASCIIStringEncoding];
    CCHmacInit(&context, kCCHmacAlgSHA256, keyCString, strlen(keyCString));
    CCHmacUpdate(&context, data.bytes, data.length);
    
    unsigned char digestRaw[CC_SHA256_DIGEST_LENGTH];
    int digestLength = CC_SHA256_DIGEST_LENGTH;
    
    CCHmacFinal(&context, digestRaw);
    return [NSData dataWithBytes:digestRaw length:digestLength];
}

+ (NSData *)AES128Decrypt:(NSData *)data key:(NSData *)key withIV:(NSData *)iv
{
    size_t bufferSize = data.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, key.bytes, kCCKeySizeAES128, iv.bytes, data.bytes, data.length, buffer, bufferSize, &numBytesDecrypted);
    if (cryptStatus == kCCSuccess){
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
    
}

+ (NSData *)decrypt:(NSString *)data key:(NSString *)key
{
    NSData *dataToDecrypt = [[NSData alloc] initWithBase64EncodedString:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSRange ivRange = {0, 16};
    NSData *iv = [dataToDecrypt subdataWithRange:ivRange];
    NSRange dataRange = {16, dataToDecrypt.length - 16};
    NSData *decrypt = (NSData *)[dataToDecrypt subdataWithRange:dataRange];
    return [Crypto AES128Decrypt:decrypt key:[Crypto hexDecode:key] withIV:iv];
}

+ (NSString *)SHA256encrypt:(NSString *)string
{
    const NSString *hashSalt = @"jcoH6gsWiMQPStc9QCVNnwQrmVpKIJzH7ck5ao9U6vzQBoKmOmQxL0byl59u2ZaL";
    NSString *input = [NSString stringWithFormat:@"%@%@", hashSalt, string];
    
    const char* str = [input UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_LONG strlength = (CC_LONG)strlen(str);
    
    CC_SHA256(str, strlength, result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++){
        [ret appendFormat:@"%02x", result[i]];
    }
    
    return [NSString stringWithString:ret];
}

@end
