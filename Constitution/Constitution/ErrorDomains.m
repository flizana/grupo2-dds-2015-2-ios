//
//  ErrorDomains.m
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "ErrorDomains.h"

NSString *const InternalServerErrorDomain = @"Internal server error";
NSInteger const InternalServerErrorCode = 000;

NSString *const NoInternetConnectionErrorDomain = @"No internet connection";
NSInteger const NoInternetConnectionErrorCode = 001;

NSString *const SignUpFieldNotSetErrorDomain = @"Sign up field not set";
NSInteger const SignUpFieldNotSetErrorCode = 102;

NSString *const SignUpFieldBlankErrorDomain = @"Sign up field blank";
NSInteger const SignUpFieldBlankErrorCode = 103;

NSString *const SaveUserFieldNotSetErrorDomain = @"Save user field not set";
NSInteger const SaveUserFieldNotSetErrorCode = 202;

NSString *const SaveUserFieldBlankErrorDomain = @"Save user field blank";
NSInteger const SaveUserFieldBlankErrorCode = 203;

NSInteger const LogInServerErrorCode = 301;

NSString *const LogInFieldNotSetErrorDomain = @"Log in field not set";
NSInteger const LogInFieldNotSetErrorCode = 302;

NSString *const LogInFieldBlankErrorDomain = @"Log in field blank";
NSInteger const LogInFieldBlankErrorCode = 303;

NSString *const CurrentUserNilErrorDomain = @"Current user is nil";
NSInteger const CurrentUserNilErrorCode = 400;
