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

@property (nonatomic) NSInteger commentId;
@property (strong, nonatomic) NSString *comment;
@property (nonatomic) NSInteger numApproval;
@property (nonatomic) NSInteger numDisapproval;

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
    User *currentUser = [User currentUser];
    if (currentUser){

        NSString *token = [currentUser getUserToken];
        
        // Set information into NSDictionary
        NSDictionary *params = @{CommentIdParameter: [NSNumber numberWithInteger:self.commentId],
                                 CommentUserIdParameter: [NSNumber numberWithInteger:[currentUser getUserId]],
                                 UserTokenParameter: token};
            
        // Set endpoint URL
        NSString *approveEndpointURL = [NSString stringWithFormat:@"%@%@", BackendEndpoint, CommentApproveEndpoint];
            
        AFHTTPSessionManager *manager = [Network sessionManager];
        
        // Check if internet connection is available
        if ([Reachability reachabilityForInternetConnection]){
            [manager POST:approveEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
                NSDictionary *responseDict = (NSDictionary *)responseObject;
                BOOL success = (BOOL)[(NSNumber *)[responseDict objectForKey:SuccessParamater] boolValue];
                if (success){
                    NSLog(@"Comment Approve Successful!");
                    result(YES, nil);
                } else {
                    NSLog(@"Error approving comment");
                    result(NO, [NSError errorWithDomain:InternalServerErrorDomain code:InternalServerErrorCode userInfo:nil]);
                }
            }failure:^(NSURLSessionDataTask *task, NSError *error){
                NSLog(@"Error approving comment: [%@]", error);
                result(NO, error);
            }];
        } else {
            result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
        }
    } else {
        result(NO, [NSError errorWithDomain:CurrentUserNilErrorDomain code:CurrentUserNilErrorCode userInfo:nil]);
    }
}

- (void)disapproveWithBlock:(void (^)(BOOL, NSError *))result
{
    User *currentUser = [User currentUser];
    if (currentUser){
            
        User *currentUser = [User currentUser];
        NSString *token = [currentUser getUserToken];
        
        // Set information into NSDictionary
        NSDictionary *params = @{CommentIdParameter: [NSNumber numberWithInteger:self.commentId],
                                 CommentUserIdParameter: [NSNumber numberWithInteger:[currentUser getUserId]],
                                 UserTokenParameter: token};
            
        // Set endpoint URL
        NSString *approveEndpointURL = [NSString stringWithFormat:@"%@%@", BackendEndpoint, CommentDisapproveEndpoint];
            
        AFHTTPSessionManager *manager = [Network sessionManager];
        
        // Check if internet connection is available
        if ([Reachability reachabilityForInternetConnection]){
            [manager POST:approveEndpointURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
                NSDictionary *responseDict = (NSDictionary *)responseObject;
                BOOL success = (BOOL)[(NSNumber *)[responseDict objectForKey:SuccessParamater] boolValue];
                if (success){
                    NSLog(@"Comment Disapprove Successful!");
                    result(YES, nil);
                } else {
                    NSLog(@"Error disapproving comment");
                    result(NO, [NSError errorWithDomain:InternalServerErrorDomain code:InternalServerErrorCode userInfo:nil]);
                }
            }failure:^(NSURLSessionDataTask *task, NSError *error){
                NSLog(@"Error disapproving comment: [%@]", error);
                result(NO, error);
            }];
        } else {
            result(NO, [NSError errorWithDomain:NoInternetConnectionErrorDomain code:NoInternetConnectionErrorCode userInfo:nil]);
        }
    } else {
        result(NO, [NSError errorWithDomain:CurrentUserNilErrorDomain code:CurrentUserNilErrorCode userInfo:nil]);
    }
}

@end
