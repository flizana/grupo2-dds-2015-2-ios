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
- (void)setPassword:(NSString *)password;
- (NSString *)getFirstName;
- (void)setFirstName:(NSString *)firstName;
- (NSString *)getLastName;
- (void)setLastName:(NSString *)lastName;
- (NSString *)getEmail;
- (void)setEmail:(NSString *)email;
- (void)setGender:(NSString *)gender;
- (void)setBirthDate:(NSDate *)birthDate;
- (void)setAge:(NSInteger)age;
- (void)setRegion:(NSString *)region;
- (void)setCity:(NSString *)city;
- (NSString *)getUserToken;
- (void)setUserToken:(NSString *)userToken;
- (void)signUp:(void (^)(BOOL, NSError *))result;
- (void)save:(void (^)(BOOL, NSError *))result;

#pragma mark - Class Methods

+ (void)logInWithEmail:(NSString *)email password:(NSString *)password block:(void (^)(BOOL, NSError *))result;

@end
