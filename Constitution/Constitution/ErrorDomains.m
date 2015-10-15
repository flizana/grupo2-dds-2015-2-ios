//
//  ErrorDomains.m
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "ErrorDomains.h"

NSString *const InternalServerErrorDomain = @"Internal server error";
NSInteger const InternalServerErrorCode = 500;

NSString *const NoInternetConnectionErrorDomain = @"No internet connection";
NSInteger const NoInternetConnectionErrorCode = 101;

NSString *const SignUpFieldBlankErrorDomain = @"Sign up field blank";
NSInteger const SignUpFieldBlankErrorCode = 103;

NSString *const SignUpFieldNotSetErrorDomain = @"Sign up field not set";
NSInteger const SignUpFieldNotSetErrorCode = 102;
