//
//  Proposal.m
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "Proposal.h"

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

- (void)approveWithUserId:(NSInteger)userId block:(void (^)(BOOL, NSError *))result
{
    // TODO: approve proposal against server
}

- (void)disapproveWithUserId:(NSInteger)userId block:(void (^)(BOOL, NSError *))result
{
    // TODO: disapprove proposal against server
}

- (void)insertComment:(NSString *)comment block:(void (^)(BOOL, NSError *))result
{
    // TODO: insert comment against server
}

@end
