//
//  APIParameters.m
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "APIParameters.h"

/* Users */
NSString *const UserParameter = @"user";
NSString *const UserIdParameter = @"user_id";
NSString *const UsernameParameter = @"username";
NSString *const FirstNameParameter = @"first_name";
NSString *const LastNameParameter = @"last_name";
NSString *const PasswordParameter = @"password";
NSString *const PasswordConfirmationParameter = @"password_confirmation";
NSString *const EmailParameter = @"email";
NSString *const GenderParameter = @"gender";
NSString *const RegionParameter = @"region";
NSString *const CityParameter = @"city";
NSString *const ProfileParameter = @"profile";
NSString *const SessionParameter = @"session";

/* Proposal */
NSString *const ProposalIdParameter = @"id";
NSString *const ProposalUserIdParameter = @"user_id";
NSString *const ProposalTitleParameter = @"titulo";
NSString *const ProposalTextParameter = @"texto";
NSString *const ProposalApprovesParameter = @"likes";
NSString *const ProposalDisapprovesParameter = @"dislikes";
NSString *const ProposalUserApprovesParameter = @"user_likes";
NSString *const ProposalUserDisapprovesParameter = @"user_dislikes";
NSString *const ProposalURLParameter = @"url";

/* Comment */
NSString *const CommentIdParameter = @"comment_id";
NSString *const CommentUserIdParameter = @"author_id";
NSString *const CommentCommentParameter = @"comments";
NSString *const CommentNumApprovalParameter = @"likes";
NSString *const CommentNumDisapprovalParameter = @"dislikes";
NSString *const CommentUserFirstNameParameter = @"author_first";
NSString *const CommentUserLastNameParameter = @"author_last";
NSString *const CommentTextParameter = @"texto";
NSString *const CommentUserApprovesParameter = @"user_likes";
NSString *const CommentUserDisapprovesParameter = @"user_dislikes";

/* HTTP Request */
NSString *const UserTokenParameter = @"user_token";
NSString *const HTTPHeaderTokenParameter = @"token";
NSString *const ApproveProposal = @"proplike";
NSString *const ApproveScore = @"score";
NSString *const ApproveComment = @"like";
NSString *const InsertComment = @"comment";
NSString *const InsertCommentText = @"texto";

/* HTTP Response */
NSString *const SuccessParamater = @"success";
NSString *const ErrorParameter = @"error";
