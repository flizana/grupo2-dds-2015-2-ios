//
//  User.m
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "User.h"
#import "KeychainAccess.h"
#import "Crypto.h"
#import "APIEndpoints.h"
#import "APIParameters.h"
#import "ErrorDomains.h"
#import <AFNetworking/AFNetworking.h>
#import <Reachability/Reachability.h>

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
    self.password = [Crypto SHA256encrypt:password];
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
    // Check if all fields are set
    if (self.password && self.firstName && self.lastName && self.email && self.gender && self.birthDate && self.age && self.region && self.city){
        // Check if a field is set but blank
        if (![self.password isEqualToString:@""] && ![self.firstName isEqualToString:@""] && ![self.lastName isEqualToString:@""] && ![self.email isEqualToString:@""] && ![self.gender isEqualToString:@""] && ![self.birthDate isEqual:[NSDate date]] && self.age != 0 && ![self.region isEqualToString:@""] && ![self.city isEqualToString:@""]){
            
            // Set information into NSDictinary
            NSDictionary *params = @{FirstNameParameter: self.firstName,
                                     LastNameParameter: self.lastName,
                                     PasswordParameter: self.password,
                                     EmailParameter: self.email,
                                     GenderParameter: self.gender,
                                     BirthDateParameter: self.birthDate,
                                     AgeParameter: [NSNumber numberWithInteger:self.age],
                                     RegionParameter: self.region,
                                     CityParameter: self.city};
            
            // Set endpoint URL
            NSString *signUpEndpointURL = [NSString stringWithFormat:@"%@%@", BackendEndpoint, SignUpEndpoint];
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            
            // Check if internet connection is available
            if ([Reachability reachabilityForInternetConnection]){
                [manager POST:signUpEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
                    NSDictionary *responseDict = (NSDictionary *)responseObject;
                    BOOL success = (BOOL)[(NSNumber *)[responseDict objectForKey:SuccessParamater] boolValue];
                    if (success){
                        NSLog(@"Sign Up Successful!");
                        result(YES, nil);
                    } else {
                        NSLog(@"Error signing up user");
                        result(NO, [NSError errorWithDomain:InternalServerErrorDomain code:InternalServerErrorCode userInfo:nil]);
                    }
                }failure:^(NSURLSessionDataTask *task, NSError *error){
                    NSLog(@"Error signing up user: [%@]", error);
                    result(NO, error);
                }];
            } else {
                result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
            }
        } else {
            result(NO, [NSError errorWithDomain:SignUpFieldBlankErrorDomain code:SignUpFieldBlankErrorCode userInfo:nil]);
        }
    } else {
        result(NO, [NSError errorWithDomain:SignUpFieldNotSetErrorDomain code:SignUpFieldNotSetErrorCode userInfo:nil]);
    }
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
