//
//  ErrorDomains.h
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const InternalServerErrorDomain;
FOUNDATION_EXPORT NSInteger const InternalServerErrorCode;

FOUNDATION_EXPORT NSString *const NoInternetConnectionErrorDomain;
FOUNDATION_EXPORT NSInteger const NoInternetConnectionErrorCode;

FOUNDATION_EXPORT NSString *const SignUpFieldBlankErrorDomain;
FOUNDATION_EXPORT NSInteger const SignUpFieldBlankErrorCode;

FOUNDATION_EXPORT NSString *const SignUpFieldNotSetErrorDomain;
FOUNDATION_EXPORT NSInteger const SignUpFieldNotSetErrorCode;

FOUNDATION_EXPORT NSString *const SaveUserFieldNotSetErrorDomain;
FOUNDATION_EXPORT NSInteger const SaveUserFieldNotSetErrorCode;

FOUNDATION_EXPORT NSString *const SaveUserFieldBlankErrorDomain;
FOUNDATION_EXPORT NSInteger const SaveUserFieldBlankErrorCode;

FOUNDATION_EXPORT NSString *const LogInFieldNotSetErrorDomain;
FOUNDATION_EXPORT NSInteger const LogInFieldNotSetErrorCode;

FOUNDATION_EXPORT NSString *const LogInFieldBlankErrorDomain;
FOUNDATION_EXPORT NSInteger const LogInFieldBlankErrorCode;
