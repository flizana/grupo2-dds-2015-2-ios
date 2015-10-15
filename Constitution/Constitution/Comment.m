//
//  Comment.m
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "Comment.h"

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

- (void)approveWithUserId:(NSInteger)userId block:(void (^)(BOOL, NSError *))result
{
    // TODO: approve comment against server
}

- (void)disapproveWithUserId:(NSInteger)userId block:(void (^)(BOOL, NSError *))result
{
    // TODO: disapprove comment against server
}

@end
