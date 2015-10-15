//
//  Network.m
//  Constitution
//
//  Created by Fernando Lizana on 10/15/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "Network.h"

@implementation Network

+ (AFHTTPSessionManager *)sessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return manager;
}

@end