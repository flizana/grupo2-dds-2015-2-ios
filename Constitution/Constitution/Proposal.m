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
#import <AFNetworking/AFNetworking.h>
#import <Reachability/Reachability.h>

@interface Proposal()

@property (nonatomic) NSInteger proposalId;
@property (strong, nonatomic) NSString *proposal;
@property (strong, nonatomic) NSArray *comments;
@property (nonatomic) NSInteger numApproval;
@property (nonatomic) NSInteger numDisapproval;

@end

@implementation Proposal

#pragma mark - Instance Methods

- (NSInteger)getProposalId
{
    return self.proposalId;
}

- (NSString *)getProposal
{
    return self.proposal;
}

- (NSArray *)getComments
{
    return self.comments;
}

- (NSInteger)getNumApproval
{
    return self.numApproval;
}

- (NSInteger)getNumDisapproval
{
    return self.numDisapproval;
}

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

- (void)approveWithUserId:(NSInteger)userId block:(void (^)(BOOL, NSError *))result
{
    if (userId){
        if (userId != 0){
            
            // Set information into NSDictionary
            NSDictionary *params = @{};
            
            // Set endpoint URL
            NSString *approveEndpointURL = [NSString stringWithFormat:@"%@%@", BackendEndpoint, ProposalApproveEndpoint];
            
            AFHTTPSessionManager *manager = [Network sessionManager];
            
            // Check if internet connection is available
            if ([Reachability reachabilityForInternetConnection]){
                [manager POST:approveEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
                    NSDictionary *responseDict = (NSDictionary *)responseObject;
                    BOOL success = (BOOL)[(NSNumber *)[responseDict objectForKey:SuccessParamater] boolValue];
                    if (success){
                        NSLog(@"Proposal Approve Successful!");
                        result(YES, nil);
                    } else {
                        NSLog(@"Error approving proposal");
                        result(NO, [NSError errorWithDomain:InternalServerErrorDomain code:InternalServerErrorCode userInfo:nil]);
                    }
                }failure:^(NSURLSessionDataTask *task, NSError *error){
                    NSLog(@"Error approving proposal: [%@]", error);
                    result(NO, error);
                }];
            } else {
                result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
            }
        } else {
            result(NO, [NSError errorWithDomain:ApprovalUserIdBlankErrorDomain code:ApprovalUserIdBlankErrorCode userInfo:nil]);
        }
    } else {
        result(NO, [NSError errorWithDomain:ApprovalUserIdNotSetErrorDomain code:ApprovalUserIdNotSetErrorCode userInfo:nil]);
    }
}

- (void)disapproveWithUserId:(NSInteger)userId block:(void (^)(BOOL, NSError *))result
{
    if (userId){
        if (userId != 0){
            
            // Set information into NSDictionary
            NSDictionary *params = @{};
            
            // Set endpoint URL
            NSString *disapproveEndpointURL = [NSString stringWithFormat:@"%@%@", BackendEndpoint, ProposalDisapproveEndpoint];
            
            AFHTTPSessionManager *manager = [Network sessionManager];
            
            // Check if internet connection is available
            if ([Reachability reachabilityForInternetConnection]){
                [manager POST:disapproveEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
                    NSDictionary *responseDict = (NSDictionary *)responseObject;
                    BOOL success = (BOOL)[(NSNumber *)[responseDict objectForKey:SuccessParamater] boolValue];
                    if (success){
                        NSLog(@"Proposal Disapprove Successful!");
                        result(YES, nil);
                    } else {
                        NSLog(@"Error disapproving proposal");
                        result(NO, [NSError errorWithDomain:InternalServerErrorDomain code:InternalServerErrorCode userInfo:nil]);
                    }
                }failure:^(NSURLSessionDataTask *task, NSError *error){
                    NSLog(@"Error disapproving proposal: [%@]", error);
                    result(NO, error);
                }];
            } else {
                result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
            }
        } else {
            result(NO, [NSError errorWithDomain:DisapprovalUserIdBlankErrorDomain code:DisapprovalUserIdBlankErrorCode userInfo:nil]);
        }
    } else {
        result(NO, [NSError errorWithDomain:DisapprovalUserIdNotSetErrorDomain code:DisapprovalUserIdNotSetErrorCode userInfo:nil]);
    }
}

- (void)insertComment:(NSString *)comment block:(void (^)(BOOL, NSError *))result
{
    // TODO: insert comment against server
}

@end
