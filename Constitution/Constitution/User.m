//
//  User.m
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "User.h"

@interface User()

@property (nonatomic) NSInteger userId;
@property (nonatomic, assign) NSString *password;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *email;
@property (nonatomic, assign) NSString *gender;
@property (nonatomic, assign) NSDate *birthDate;
@property (nonatomic) NSInteger age;
@property (nonatomic, assign) NSString *region;
@property (nonatomic, assign) NSString *city;
@property (strong, nonatomic) NSString *userToken;

@end

@implementation User

#pragma mark - Instance Methods

- (NSInteger)getUserId
{
    // TODO: return user id
    return 0;
}

- (void)setPassword:(NSString *)password
{
    // TODO: set password
}

- (NSString *)getFirstName
{
    // TODO: return first name
    return @"";
}

- (void)setFirstName:(NSString *)firstName
{
    // TODO: set first name
}

- (NSString *)getLastName
{
    // TODO: return last name
    return @"";
}

- (void)setLastName:(NSString *)lastName
{
    // TODO: set last name
}

- (NSString *)getEmail
{
    // TODO: return email
    return @"";
}

- (void)setEmail:(NSString *)email
{
    // TODO: set email
}

- (void)setGender:(NSString *)gender
{
    // TODO: set gender
}

- (void)setBirthDate:(NSDate *)birthDate
{
    // TODO: set birth date
}

- (void)setAge:(NSInteger)age
{
    // TODO: set age
}

- (void)setRegion:(NSString *)region
{
    // TODO: set region
}

- (void)setCity:(NSString *)city
{
    // TODO: set city
}

- (NSString *)getUserToken
{
    // TODO: get user token
    // This is more tricky, first retrieve from keychain and then return it
    return @"";
}

- (void)setUserToken:(NSString *)userToken
{
    // TODO: set user token
    // This is more tricky, save token into keychain
}

- (void)signUp:(void (^)(BOOL, NSError *))result
{
    // TODO: sign up user against server
}

- (void)save:(void (^)(BOOL, NSError *))result
{
    // TODO: save user against server
}


#pragma mark - Class Methods

+ (void)logInWithEmail:(NSString *)email password:(NSString *)password block:(void (^)(BOOL, NSError *))result
{
    // TODO: log in with credentials against server
}

@end
