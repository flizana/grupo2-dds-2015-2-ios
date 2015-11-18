//
//  Comment.h
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic) unsigned long commentId;
@property (strong, nonatomic) NSString *comment;
@property (nonatomic) unsigned long userId;
@property (nonatomic) unsigned long proposalId;
@property (strong, nonatomic) NSString *userFirstName;
@property (strong, nonatomic) NSString *userLastName;
@property (nonatomic) unsigned long numApproval;
@property (nonatomic) unsigned long numDisapproval;
@property (nonatomic) BOOL userApproves;
@property (nonatomic) BOOL userDisapproves;

#pragma mark - Instance Methods

- (id)initWithComment:(NSString *)comment;
- (NSInteger)getCommentId;
- (NSString *)getComment;
- (NSInteger)getNumApproval;
- (NSInteger)getNumDisapproval;
- (void)approveWithBlock:(void (^)(BOOL, NSError *))result;
- (void)disapproveWithBlock:(void (^)(BOOL, NSError *))result;

@end
