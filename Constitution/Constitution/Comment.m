//
//  Comment.m
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "Comment.h"
#import "ErrorDomains.h"
#import "APIEndpoints.h"
#import "APIParameters.h"
#import "Network.h"
#import "User.h"
#import <AFNetworking/AFNetworking.h>
#import <Reachability/Reachability.h>

@interface Comment()

@end

@implementation Comment

- (id)initWithComment:(NSString *)comment
{
    if ((self = [super init])){
        self.comment = comment;
        self.numApproval = 0;
        self.numDisapproval = 0;
        
        return self;
    }
    
    return nil;
}

- (NSInteger)getCommentId
{
    return self.commentId;
}

- (NSString *)getComment
{
    return self.comment;
}

- (NSInteger)getNumApproval
{
    return self.numApproval;
}

- (NSInteger)getNumDisapproval
{
    return self.numDisapproval;
}

- (void)approveWithBlock:(void (^)(BOOL, NSError *))result
{
    // Set information into NSDictionary
    NSDictionary *params = @{ApproveComment: @{ApproveScore: @1}};
            
    // Set endpoint URL
    NSString *approveEndpointURL = [NSString stringWithFormat:@"%@%@%li%@%li%@", BackendEndpoint, CommentsEndpoint, self.proposalId, CommentsCommentEndpoint, self.commentId, CommentApproveEndpoint];
            
    AFHTTPSessionManager *manager = [Network authSessionManager];
        
    // Check if internet connection is available
    if ([Reachability reachabilityForInternetConnection]){
        [manager POST:approveEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
            result(YES, nil);
        }failure:^(NSURLSessionDataTask *task, NSError *error){
            NSLog(@"Error approving comment: [%@]", error);
            result(NO, error);
        }];
    } else {
        result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
    }
}

- (void)disapproveWithBlock:(void (^)(BOOL, NSError *))result
{
    // Set information into NSDictionary
    NSDictionary *params = @{ApproveComment: @{ApproveScore: @-1}};
            
    // Set endpoint URL
    NSString *approveEndpointURL = [NSString stringWithFormat:@"%@%@%li%@%li%@", BackendEndpoint, CommentsEndpoint, self.proposalId, CommentsCommentEndpoint, self.commentId, CommentDisapproveEndpoint];
            
    AFHTTPSessionManager *manager = [Network authSessionManager];
        
    // Check if internet connection is available
    if ([Reachability reachabilityForInternetConnection]){
        [manager POST:approveEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
            result(YES, nil);
        }failure:^(NSURLSessionDataTask *task, NSError *error){
            NSLog(@"Error disapproving comment: [%@]", error);
            result(NO, error);
        }];
    } else {
        result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
    }
}

@end
