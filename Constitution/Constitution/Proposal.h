//
//  Proposal.h
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Proposal : NSObject

#pragma mark - Instance Methods

- (NSInteger)getProposalId;
- (NSString *)getProposal;
- (NSArray *)getComments;
- (NSInteger)getNumApproval;
- (NSInteger)getNumDisapproval;
- (void)approveWithBlock:(void (^)(BOOL, NSError *))result;
- (void)disapproveWithBlock:(void (^)(BOOL, NSError *))result;
- (void)insertComment:(NSString *)comment block:(void (^)(BOOL, NSError *))result;

@end
