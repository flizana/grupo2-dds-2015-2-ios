//
//  User.m
//  Constitution
//
//  Created by Fernando Lizana on 10/13/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "User.h"

@interface User()

@property (nonatomic) NSInteger userId;
@property (nonatomic, assign) NSString *password;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *email;
@property (nonatomic, assign) NSString *gender;
@property (nonatomic, assign) NSDate *birthDate;
@property (nonatomic) NSInteger age;
@property (nonatomic, assign) NSString *region;
@property (nonatomic, assign) NSString *city;
@property (strong, nonatomic) NSString *userToken;

@end

@implementation User

@end
