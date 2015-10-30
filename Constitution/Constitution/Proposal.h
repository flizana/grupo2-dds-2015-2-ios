//
//  Proposal.h
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Proposal : NSObject

@property (nonatomic) unsigned long proposalId;
@property (strong, nonatomic) NSString *proposalText;
@property (nonatomic) unsigned long userId;
@property (strong, nonatomic) NSString *proposalURL;
@property (strong, nonatomic) NSArray *comments;
@property (nonatomic) NSInteger numApproval;
@property (nonatomic) NSInteger numDisapproval;

#pragma mark - Instance Methods

- (void)approveWithBlock:(void (^)(BOOL, NSError *))result;
- (void)disapproveWithBlock:(void (^)(BOOL, NSError *))result;
- (void)insertComment:(NSString *)comment block:(void (^)(BOOL, NSError *))result;

@end
