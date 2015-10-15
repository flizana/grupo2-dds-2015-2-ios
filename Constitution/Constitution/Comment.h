//
//  Comment.h
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

#pragma mark - Instance Methods

- (id)initWithComment:(NSString *)comment;
- (NSInteger)getCommentId;
- (NSString *)getComment;
- (NSInteger)getNumApproval;
- (NSInteger)getNumDisapproval;
- (void)approveWithUserId:(NSInteger)userId block:(void (^)(BOOL, NSError *))result;
- (void)disapproveWithUserId:(NSInteger)userId block:(void (^)(BOOL, NSError *))result;

@end
