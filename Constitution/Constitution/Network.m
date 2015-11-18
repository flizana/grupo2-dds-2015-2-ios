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

+ (AFHTTPSessionManager *)authSessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    User *currentUser = [User currentUser];
    if (currentUser){
        [manager.requestSerializer setValue:[currentUser getUserToken] forHTTPHeaderField:HTTPHeaderTokenParameter];
    }
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return manager;
}

+ (void)downloadProposalsWithBlock:(void (^)(BOOL, NSError *, NSArray *))result
{
    User *currentUser = [User currentUser];
    if (!currentUser){
        result(NO, [NSError errorWithDomain:CurrentUserNilErrorDomain code:CurrentUserNilErrorCode userInfo:nil], nil);
    } else {
        // Set endpoint URL
        NSString *proposalsEndpointURL = [NSString stringWithFormat:@"%@%@", BackendEndpoint, ProposalsEndpoint];
        
        AFHTTPSessionManager *manager = [Network authSessionManager];
        
        // Check if internet connection is available
        if ([Reachability reachabilityForInternetConnection]){
            [manager GET:proposalsEndpointURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){
                NSArray *responseArray = (NSArray *)responseObject;
                result(YES, nil, responseArray);
            }failure:^(NSURLSessionDataTask *task, NSError *error){
                NSLog(@"Error downloading proposals: [%@]", error);
                result(NO, error, nil);
            }];
        } else {
            result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil], nil);
        }
    }
}

+ (void)downloadCommentsForProposalId:(unsigned long)proposalId withBLock:(void (^)(BOOL, NSError *, NSArray *))result
{
    User *currentUser = [User currentUser];
    if (!currentUser){
        result(NO, [NSError errorWithDomain:CurrentUserNilErrorDomain code:CurrentUserNilErrorCode userInfo:nil], nil);
    } else {
        // Set information into NSDictionary
        NSDictionary *params = @{UserIdParameter: [NSNumber numberWithLong:[currentUser getUserId]],
                                 UserTokenParameter: [currentUser getUserToken]};
        
        // Set endpoint URL
        NSString *idString = [NSString stringWithFormat:@"%li", proposalId];
        NSString *commentsEndpointURL = [NSString stringWithFormat:@"%@%@%@%@", BackendEndpoint, CommentsEndpoint, idString, @".json"];
        
        AFHTTPSessionManager *manager = [Network sessionManager];
        
        // Check if internet connection is available
        if ([Reachability reachabilityForInternetConnection]){
            [manager GET:commentsEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
                NSDictionary *responseDict = (NSDictionary *)responseObject;
                NSArray *commentsArray = (NSArray *)[responseDict objectForKey:CommentCommentParameter];
                result(YES, nil, commentsArray);
            }failure:^(NSURLSessionDataTask *task, NSError *error){
                NSLog(@"Error downloading comments: [%@]", error);
                result(NO, error, nil);
            }];
        } else {
            result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil], nil);
        }
    }
}

@end
