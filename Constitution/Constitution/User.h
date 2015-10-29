//
//  User.h
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

#pragma mark - Instance Methods

- (NSInteger)getUserId;
- (void)syncPassword:(NSString *)password;
- (NSString *)getFirstName;
- (void)syncFirstName:(NSString *)firstName;
- (NSString *)getLastName;
- (void)syncLastName:(NSString *)lastName;
- (NSString *)getEmail;
- (void)syncEmail:(NSString *)email;
- (void)syncGender:(NSString *)gender;
- (void)syncRegion:(NSString *)region;
- (void)syncCity:(NSString *)city;
- (NSString *)getUserToken;
- (void)syncUserToken:(NSString *)userToken;
- (void)signUp:(void (^)(BOOL, NSError *))result;
- (void)save:(void (^)(BOOL, NSError *))result;

#pragma mark - Class Methods

+ (instancetype)currentUser;
+ (void)logInWithEmail:(NSString *)email password:(NSString *)password block:(void (^)(BOOL, NSError *))result;
+ (void)logOut;

@end
