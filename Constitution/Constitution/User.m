//
//  User.m
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "User.h"
#import "KeychainAccess.h"

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

@end

@implementation User

#pragma mark - Instance Methods

- (NSInteger)getUserId
{
    return self.userId;
}

- (void)setPassword:(NSString *)password
{
    self.password = password;
}

- (NSString *)getFirstName
{
    return self.firstName;
}

- (void)setFirstName:(NSString *)firstName
{
    self.firstName = firstName;
}

- (NSString *)getLastName
{
    return self.lastName;
}

- (void)setLastName:(NSString *)lastName
{
    self.lastName = lastName;
}

- (NSString *)getEmail
{
    return self.email;
}

- (void)setEmail:(NSString *)email
{
    self.email = email;
}

- (void)setGender:(NSString *)gender
{
    self.gender = gender;
}

- (void)setBirthDate:(NSDate *)birthDate
{
    self.birthDate = birthDate;
}

- (void)setAge:(NSInteger)age
{
    self.age = age;
}

- (void)setRegion:(NSString *)region
{
    self.region = region;
}

- (void)setCity:(NSString *)city
{
    self.city = city;
}

- (NSString *)getUserToken
{
    KeychainAccess *keychain = [[KeychainAccess alloc] init];
    return (NSString *)[keychain myObjectForKey:self.email];
}

- (void)setUserToken:(NSString *)userToken
{
    KeychainAccess *keychain = [[KeychainAccess alloc] init];
    [keychain mySetObject:userToken forKey:self.email];
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
