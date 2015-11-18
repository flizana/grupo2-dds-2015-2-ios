//
//  Proposal.m
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "Proposal.h"
#import "ErrorDomains.h"
#import "Network.h"
#import "APIEndpoints.h"
#import "APIParameters.h"
#import "User.h"
#import "Comment.h"
#import <AFNetworking/AFNetworking.h>
#import <Reachability/Reachability.h>

@interface Proposal()

@end

@implementation Proposal

#pragma mark - Instance Methods

- (void)incrementApproval
{
    self.numApproval++;
}

- (void)incrementDisapproval
{
    self.numDisapproval++;
}

- (void)decrementApproval
{
    self.numApproval--;
}

- (void)decrementDisapproval
{
    self.numDisapproval--;
}

- (void)approveWithBlock:(void (^)(BOOL, NSError *))result
{
    // Set information into NSDictionary
    NSDictionary *params = @{ApproveProposal: @{ApproveScore: @1}};
            
    // Set endpoint URL
    NSString *approveEndpointURL = [NSString stringWithFormat:@"%@%@%li%@", BackendEndpoint, CommentsEndpoint, self.proposalId, ProposalApproveEndpoint];
            
    AFHTTPSessionManager *manager = [Network authSessionManager];
            
    // Check if internet connection is available
    if ([Reachability reachabilityForInternetConnection]){
        [manager POST:approveEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
            result(YES, nil);
        }failure:^(NSURLSessionDataTask *task, NSError *error){
            NSLog(@"Error approving proposal: [%@]", error);
            result(NO, error);
        }];
    } else {
        result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
    }
}

- (void)disapproveWithBlock:(void (^)(BOOL, NSError *))result
{
    // Set information into NSDictionary
    NSDictionary *params = @{ApproveProposal: @{ApproveScore: @-1}};
            
    // Set endpoint URL
    NSString *disapproveEndpointURL = [NSString stringWithFormat:@"%@%@%li%@", BackendEndpoint, CommentsEndpoint, self.proposalId, ProposalDisapproveEndpoint];
            
    AFHTTPSessionManager *manager = [Network authSessionManager];
            
    // Check if internet connection is available
    if ([Reachability reachabilityForInternetConnection]){
        [manager POST:disapproveEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
            result(YES, nil);
        }failure:^(NSURLSessionDataTask *task, NSError *error){
            NSLog(@"Error disapproving proposal: [%@]", error);
            result(NO, error);
        }];
    } else {
        result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
    }
}

- (void)insertComment:(NSString *)comment block:(void (^)(BOOL, NSError *))result
{
    // Set information into NSDictionary
    NSDictionary *params = @{InsertComment:@{InsertCommentText:comment}};
        
    // Set endpoint URL
    NSString *insertCommentEndpointURL = [NSString stringWithFormat:@"%@%@%li%@", BackendEndpoint, CommentsEndpoint, self.proposalId, InsertCommentEndpoint];
        
    AFHTTPSessionManager *manager = [Network authSessionManager];
        
    // Check if internet connection is available
    if ([Reachability reachabilityForInternetConnection]){
        [manager POST:insertCommentEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
            result(YES, nil);
        }failure:^(NSURLSessionDataTask *task, NSError *error){
            NSLog(@"Error inserting comment: [%@]", error);
            result(NO, error);
        }];
    } else {
        result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
    }
}

@end
