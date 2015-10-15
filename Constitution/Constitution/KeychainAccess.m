//
//  KeychainAccess.m
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "KeychainAccess.h"

static const UInt8 kKeychainItemIdentifier[] = "com.apple.dts.KeychainUI\0";

@interface KeychainAccess()

@property (strong, nonatomic) id tempObject;
@property (strong, nonatomic) id tempKey;

@end

@implementation KeychainAccess

@synthesize keychainData, genericPasswordQuery;

- (BOOL)mySetObject:(id)inObject forKey:(id)key
{
    if (inObject == nil) return false;
    
    NSData *objectData = nil;
    if ([inObject isKindOfClass:[NSString class]]){
        objectData = [inObject dataUsingEncoding:NSUTF8StringEncoding];
    }
    NSString *service = [[NSBundle mainBundle] bundleIdentifier];
    NSData *keychainItemID = [NSData dataWithBytes:kKeychainItemIdentifier length:strlen((const char *)kKeychainItemIdentifier)];
    
    NSDictionary *secItem = @{(__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                              (__bridge id)kSecAttrService : service,
                              (__bridge id)kSecAttrAccount : key,
                              (__bridge id)kSecValueData : objectData,
                              (__bridge id)kSecAttrGeneric: keychainItemID
                              };
    
    CFTypeRef result = NULL;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)secItem, &result);
    
    if (status == errSecSuccess){
        return true;
    } else {
        return false;
    }
}

- (id)myObjectForKey:(id)key
{
    NSString *service = [[NSBundle mainBundle] bundleIdentifier];
    NSData *keychainItemID = [NSData dataWithBytes:kKeychainItemIdentifier length:strlen((const char *)kKeychainItemIdentifier)];
    
    NSDictionary *query = @{
                            (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService : service,
                            (__bridge id)kSecAttrAccount : key,
                            (__bridge id)kSecReturnData : (__bridge id)kCFBooleanTrue,
                            (__bridge id)kSecAttrGeneric: keychainItemID
                            };
    
    CFDataRef cfValue = NULL;
    OSStatus results = SecItemCopyMatching((__bridge CFDictionaryRef)query,
                                           (CFTypeRef *)&cfValue);
    
    if (results == errSecSuccess){
        return [[NSString alloc]
                initWithData:(__bridge_transfer NSData *)cfValue
                encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

- (BOOL)deleteObjectForKey:(id)key
{
    NSData *keychainItemID = [NSData dataWithBytes:kKeychainItemIdentifier length:strlen((const char *)kKeychainItemIdentifier)];
    NSDictionary *dict = @{(__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                           (__bridge id)kSecAttrService: [[NSBundle mainBundle] bundleIdentifier],
                           (__bridge id)kSecAttrAccount: key,
                           (__bridge id)kSecAttrGeneric: keychainItemID
                           };
    
    OSStatus foundExisting = SecItemCopyMatching((__bridge CFDictionaryRef)dict, NULL);
    if (foundExisting == errSecSuccess){
        OSStatus deleted = SecItemDelete((__bridge CFDictionaryRef)dict);
        if (deleted == errSecSuccess){
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
}

@end
