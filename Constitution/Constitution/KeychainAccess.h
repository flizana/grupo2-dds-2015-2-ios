//
//  KeychainAccess.h
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface KeychainAccess : NSObject
{
    NSMutableDictionary *keychainData;
    NSMutableDictionary *genericPasswordQuery;
}

@property (strong, nonatomic) NSMutableDictionary *keychainData;
@property (strong, nonatomic) NSMutableDictionary *genericPasswordQuery;

- (BOOL)mySetObject:(id)inObject forKey:(id)key;
- (id)myObjectForKey:(id)key;
- (BOOL)deleteObjectForKey:(id)key;

@end
