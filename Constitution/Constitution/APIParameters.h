//
//  APIParameters.h
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Users */
FOUNDATION_EXPORT NSString *const UserParameter;
FOUNDATION_EXPORT NSString *const UserIdParameter;
FOUNDATION_EXPORT NSString *const UsernameParameter;
FOUNDATION_EXPORT NSString *const FirstNameParameter;
FOUNDATION_EXPORT NSString *const LastNameParameter;
FOUNDATION_EXPORT NSString *const PasswordParameter;
FOUNDATION_EXPORT NSString *const PasswordConfirmationParameter;
FOUNDATION_EXPORT NSString *const EmailParameter;
FOUNDATION_EXPORT NSString *const GenderParameter;
FOUNDATION_EXPORT NSString *const RegionParameter;
FOUNDATION_EXPORT NSString *const CityParameter;
FOUNDATION_EXPORT NSString *const ProfileParameter;
FOUNDATION_EXPORT NSString *const SessionParameter;

/* Proposal */
FOUNDATION_EXPORT NSString *const ProposalIdParameter;
FOUNDATION_EXPORT NSString *const ProposalUserIdParameter;
FOUNDATION_EXPORT NSString *const ProposalTitleParameter;
FOUNDATION_EXPORT NSString *const ProposalTextParameter;
FOUNDATION_EXPORT NSString *const ProposalApprovesParameter;
FOUNDATION_EXPORT NSString *const ProposalDisapprovesParameter;
FOUNDATION_EXPORT NSString *const ProposalUserApprovesParameter;
FOUNDATION_EXPORT NSString *const ProposalUserDisapprovesParameter;
FOUNDATION_EXPORT NSString *const ProposalURLParameter;

/* Comment */
FOUNDATION_EXPORT NSString *const CommentIdParameter;
FOUNDATION_EXPORT NSString *const CommentUserIdParameter;
FOUNDATION_EXPORT NSString *const CommentCommentParameter;
FOUNDATION_EXPORT NSString *const CommentNumApprovalParameter;
FOUNDATION_EXPORT NSString *const CommentNumDisapprovalParameter;
FOUNDATION_EXPORT NSString *const CommentUserFirstNameParameter;
FOUNDATION_EXPORT NSString *const CommentUserLastNameParameter;
FOUNDATION_EXPORT NSString *const CommentTextParameter;
FOUNDATION_EXPORT NSString *const CommentUserApprovesParameter;
FOUNDATION_EXPORT NSString *const CommentUserDisapprovesParameter;

/* HTTP Request */
FOUNDATION_EXPORT NSString *const UserTokenParameter;
FOUNDATION_EXPORT NSString *const HTTPHeaderTokenParameter;
FOUNDATION_EXPORT NSString *const ApproveProposal;
FOUNDATION_EXPORT NSString *const ApproveScore;
FOUNDATION_EXPORT NSString *const ApproveComment;
FOUNDATION_EXPORT NSString *const InsertComment;
FOUNDATION_EXPORT NSString *const InsertCommentText;

/* HTTP Response */
FOUNDATION_EXPORT NSString *const SuccessParamater;
FOUNDATION_EXPORT NSString *const ErrorParameter;
