//
//  Network.m
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "Network.h"
#import "User.h"
#import "ErrorDomains.h"
#import "APIParameters.h"
#import "APIEndpoints.h"
#import <Reachability/Reachability.h>

@implementation Network

+ (AFHTTPSessionManager *)sessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return manager;
}

+ (void)downloadProposalsWithBlock:(void (^)(BOOL, NSError *))result
{
    User *currentUser = [User currentUser];
    if (!currentUser){
        result(NO, [NSError errorWithDomain:CurrentUserNilErrorDomain code:CurrentUserNilErrorCode userInfo:nil]);
    } else {
        // Set information into NSDictionary
        NSDictionary *params = @{UserIdParameter: [NSNumber numberWithInteger:[currentUser getUserId]],
                                 UserTokenParameter: [currentUser getUserToken]};
        
        // Set endpoint URL
        NSString *proposalsEndpointURL = [NSString stringWithFormat:@"%@%@", BackendEndpoint, ProposalsEndpoint];
        
        AFHTTPSessionManager *manager = [Network sessionManager];
        
        // Check if internet connection is available
        if ([Reachability reachabilityForInternetConnection]){
            [manager GET:proposalsEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
                NSDictionary *responseDict = (NSDictionary *)responseObject;
                BOOL success = (BOOL)[(NSNumber *)[responseDict objectForKey:SuccessParamater] boolValue];
                if (success){
                    // Download success
                    NSLog(@"Download success");
                } else {
                    NSLog(@"Error downloading proposals");
                    result(NO, [NSError errorWithDomain:InternalServerErrorDomain code:InternalServerErrorCode userInfo:nil]);
                }
            }failure:^(NSURLSessionDataTask *task, NSError *error){
                NSLog(@"Error downloading proposals: [%@]", error);
                result(NO, error);
            }];
        } else {
            result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
        }
    }
}

@end
