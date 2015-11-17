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
#import "Network.h"
#import <AFNetworking/AFNetworking.h>
#import <Reachability/Reachability.h>

@interface User()

@property (nonatomic) unsigned long userId;
@property (nonatomic, assign) NSString *password;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *email;
@property (nonatomic, assign) NSString *gender;
@property (nonatomic, assign) NSString *region;
@property (nonatomic, assign) NSString *city;

@end

static User *currentUser = nil;

@implementation User

#pragma mark - Instance Methods

- (NSInteger)getUserId
{
    return self.userId;
}

- (void)syncPassword:(NSString *)password
{
    self.password = [Crypto SHA256encrypt:password];
}

- (NSString *)getFirstName
{
    return self.firstName;
}

- (void)syncFirstName:(NSString *)firstName
{
    self.firstName = [NSString stringWithString:firstName];
}

- (NSString *)getLastName
{
    return self.lastName;
}

- (void)syncLastName:(NSString *)lastName
{
    self.lastName = lastName;
}

- (NSString *)getEmail
{
    return self.email;
}

- (void)syncEmail:(NSString *)email
{
    self.email = email;
}

- (void)syncGender:(NSString *)gender
{
    self.gender = gender;
}

- (void)syncRegion:(NSString *)region
{
    self.region = region;
}

- (void)syncCity:(NSString *)city
{
    self.city = city;
}

- (NSString *)getUserToken
{
    KeychainAccess *keychain = [[KeychainAccess alloc] init];
    return (NSString *)[keychain myObjectForKey:self.email];
}

- (void)syncUserToken:(NSString *)userToken
{
    KeychainAccess *keychain = [[KeychainAccess alloc] init];
    [keychain mySetObject:userToken forKey:self.email];
}

- (void)signUp:(void (^)(BOOL success, NSError *error))result
{
    // Check if all fields are set
    if (self.password && self.firstName && self.lastName && self.email){
        // Check if a field is set but blank
        if (![self.password isEqualToString:@""] && ![self.firstName isEqualToString:@""] && ![self.lastName isEqualToString:@""] && ![self.email isEqualToString:@""]){
            
            // Set information into NSDictionary
            NSDictionary *params = @{UserParameter:@{ FirstNameParameter: self.firstName,
                                                      LastNameParameter: self.lastName,
                                                      PasswordParameter: self.password,
                                                      PasswordConfirmationParameter: self.password,
                                                      EmailParameter: self.email,
                                                      GenderParameter: self.gender,
                                                      RegionParameter: self.region,
                                                      CityParameter: self.city}};
            
            // Set endpoint URL
            NSString *signUpEndpointURL = [NSString stringWithFormat:@"%@%@", BackendEndpoint, SignUpEndpoint];
            
            AFHTTPSessionManager *manager = [Network sessionManager];
            
            // Check if internet connection is available
            if ([Reachability reachabilityForInternetConnection]){
                [manager POST:signUpEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
                    NSDictionary *responseDict = (NSDictionary *)responseObject;
                    unsigned long userId = (long)[(NSNumber *)[responseDict objectForKey:UserIdParameter] longValue];
                    NSString *firstName = (NSString *)[responseDict objectForKey:FirstNameParameter];
                    NSString *lastName = (NSString *)[responseDict objectForKey:LastNameParameter];
                    NSString *email = (NSString *)[responseDict objectForKey:EmailParameter];
                    NSString *token = (NSString *)[responseDict objectForKey:UserTokenParameter];
                    NSDictionary *user = [NSDictionary dictionaryWithObjectsAndKeys:
                                          firstName, FirstNameParameter,
                                          lastName, LastNameParameter,
                                          email, EmailParameter,
                                          [NSNumber numberWithUnsignedLong:userId], UserIdParameter,
                                          token, UserTokenParameter,
                                          nil];
                    [User setCurrentUser:user];
                    result(YES, nil);
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

- (void)save:(void (^)(BOOL success, NSError *error))result
{
    // Check if all fields are set
    if (self.firstName && self.lastName && self.email){
        // Check if a field is set but blank
        if (![self.firstName isEqualToString:@""] && ![self.lastName isEqualToString:@""] && ![self.email isEqualToString:@""]){
            
            // Set information into NSDictionary
            NSDictionary *params = @{FirstNameParameter: self.firstName,
                                     LastNameParameter: self.lastName,
                                     EmailParameter: self.email};
            
            // Set endpoint URL
            NSString *saveUserEndpointURL = [NSString stringWithFormat:@"%@%@", BackendEndpoint, SaveUserEndpoint];
            
            AFHTTPSessionManager *manager = [Network sessionManager];
            
            // Check if internet connection is available
            if ([Reachability reachabilityForInternetConnection]){
                [manager POST:saveUserEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
                    NSDictionary *responseDict = (NSDictionary *)responseObject;
                    BOOL success = (BOOL)[(NSNumber *)[responseDict objectForKey:SuccessParamater] boolValue];
                    if (success){
                        NSLog(@"User Saved Successfully!");
                        result(YES, nil);
                    } else {
                        NSLog(@"Error saving user");
                        result(NO, [NSError errorWithDomain:InternalServerErrorDomain code:InternalServerErrorCode userInfo:nil]);
                    }
                }failure:^(NSURLSessionDataTask *task, NSError *error){
                    NSLog(@"Error saving user: [%@]", error);
                    result(NO, error);
                }];
            } else {
                result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
            }
        } else {
            result(NO, [NSError errorWithDomain:SaveUserFieldBlankErrorDomain code:SaveUserFieldBlankErrorCode userInfo:nil]);
        }
    } else {
        result(NO, [NSError errorWithDomain:SaveUserFieldNotSetErrorDomain code:SaveUserFieldNotSetErrorCode userInfo:nil]);
    }
}

#pragma mark - Class Methods

+ (instancetype)currentUser
{
    return currentUser;
}

+ (void)setCurrentUser:(NSDictionary *)user
{
    if (!currentUser){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^(void){
            currentUser = [[User alloc] init];
            currentUser.userId = [(NSNumber *)[user objectForKey:UserIdParameter] longValue];
            currentUser.firstName = [user objectForKey:FirstNameParameter];
            currentUser.lastName = [user objectForKey:LastNameParameter];
            currentUser.email = [user objectForKey:EmailParameter];
            [currentUser syncUserToken:[user objectForKey:UserTokenParameter]];
        });
    }
}

+ (void)logInWithEmail:(NSString *)email password:(NSString *)password block:(void (^)(BOOL success, NSError *error))result
{
    // Check if credentials are set
    if (email && password){
        // Check if credentials are set but blank
        if (![email isEqualToString:@""] && ![password isEqualToString:@""]){
            
            // Hash password
            NSString *hashedPassword = [Crypto SHA256encrypt:password];
            
            // Set information into NSDictionary
            NSDictionary *params = @{EmailParameter: email,
                                     PasswordParameter: hashedPassword};
            
            // Set endpoint URL
            NSString *logInEndpointURL = [NSString stringWithFormat:@"%@%@", BackendEndpoint, LogInEndpoint];
            
            AFHTTPSessionManager *manager = [Network sessionManager];
            
            // Check if internet connection is available
            if ([Reachability reachabilityForInternetConnection]){
                [manager POST:logInEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
                    NSDictionary *responseDict = (NSDictionary *)responseObject;
                    unsigned long userId = (long)[(NSNumber *)[responseDict objectForKey:@"user_id"] longValue];
                    NSString *token = (NSString *)[responseDict objectForKey:@"token"];
                    NSString *profileEndpointURL = (NSString *)[responseDict objectForKey:ProfileParameter];
                    NSMutableDictionary *user = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                 [NSNumber numberWithUnsignedLong:userId], UserIdParameter,
                                                 token, UserTokenParameter,
                                                 nil];
                    [manager GET:profileEndpointURL parameters:[NSDictionary dictionaryWithDictionary:user] success:^(NSURLSessionDataTask *task, id responseObject){
                        NSDictionary *responseDict = (NSDictionary *)responseObject;
                        NSString *email = (NSString *)[responseDict objectForKey:EmailParameter];
                        NSString *firstName = (NSString *)[responseDict objectForKey:FirstNameParameter];
                        NSString *lastName = (NSString *)[responseDict objectForKey:LastNameParameter];
                        
                        [user setObject:email forKey:EmailParameter];
                        [user setObject:firstName forKey:FirstNameParameter];
                        [user setObject:lastName forKey:LastNameParameter];
                        
                        [User setCurrentUser:[NSDictionary dictionaryWithDictionary:user]];
                        result(YES, nil);
                        
                    }failure:^(NSURLSessionDataTask *task, NSError *error){
                        NSLog(@"Error getting profile data: [%@]", error);
                        result(NO, error);
                    }];
                }failure:^(NSURLSessionDataTask *task, NSError *error){
                    NSLog(@"Error logging in user: [%@]", error);
                    result(NO, error);
                }];
            } else {
                result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
            }
        } else {
            result(NO, [NSError errorWithDomain:LogInFieldBlankErrorDomain code:LogInFieldBlankErrorCode userInfo:nil]);
        }
    } else {
        result(NO, [NSError errorWithDomain:LogInFieldNotSetErrorDomain code:LogInFieldNotSetErrorCode userInfo:nil]);
    }
}

+ (void)logOut
{
    currentUser = nil;
}

@end
