//
//  APIEndpoints.m
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIEndpoints.h"

NSString *const BackendEndpoint = @"http://laconstitucion.cloudapp.net";
NSString *const SignUpEndpoint = @"/users.json";
NSString *const LogInEndpoint = @"/login.json";
NSString *const SaveUserEndpoint = @"";
NSString *const ProposalsEndpoint = @"/proposals.json";
NSString *const ProposalApproveEndpoint = @"/proplikes.json";
NSString *const ProposalDisapproveEndpoint = @"/proplikes.json";
NSString *const CommentsEndpoint = @"/proposals/";
NSString *const CommentsCommentEndpoint = @"/comments/";
NSString *const CommentApproveEndpoint = @"/likes.json";
NSString *const CommentDisapproveEndpoint = @"/likes.json";
NSString *const InsertCommentEndpoint = @"/comments.json";
NSString *const UsersEndpoint = @"/users";
