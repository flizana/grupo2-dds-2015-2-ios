//
//  Network.h
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface Network : NSObject

+ (AFHTTPSessionManager *)sessionManager;
+ (AFHTTPSessionManager *)authSessionManager;
+ (void)downloadProposalsWithBlock:(void (^)(BOOL, NSError *, NSArray *))result;
+ (void)downloadCommentsForProposalId:(unsigned long)proposalId withBLock:(void (^)(BOOL, NSError *, NSArray *))result;

@end
