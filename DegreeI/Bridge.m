//
//  Bridge.m
//  DegreeI
//
//  Created by Tyler Spaeth on 11/28/15.
//  Copyright © 2015 Tyler Spaeth. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Bridge.h"

@implementation Bridge

- (instancetype)init {
    self = [super init];
    
    self.socket = [[AsyncSocket alloc] initWithDelegate:self];
    NSError *e;
    [self.socket connectToHost:@"169.254.22.22" onPort:1342 error:&e];
    NSLog(@"%@", e);
    return self;
}

- (void)distanceDidChange:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    NSDictionary *point = info[@"point"];
    double speed = [info[@"speed"] doubleValue];
    
    double x = [(point[@"x"]) doubleValue];
    double y = [(point[@"y"]) doubleValue];

    double p[4];
    p[0] = x;
    p[1] = y;
    p[2] = speed;
    
    char *a = (char *)(&(p[3]));
    
    a[0] = '1';
    a[1] = '2';
    a[2] = '3';
    a[3] = '4';
    a[4] = '1';
    a[5] = '2';
    a[6] = '3';
    a[7] = '4';
    NSData *data = [NSData dataWithBytes:p length:4*sizeof(double)];
    
    NSLog(@"%@", self.socket);
    
    [self.socket writeData:data withTimeout:1 tag:0];
}

@end
