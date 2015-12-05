//
//  ViewController.m
//  DegreeI
//
//  Created by Tyler Spaeth on 11/27/15.
//  Copyright © 2015 Tyler Spaeth. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.count != 2) {
        return;
    }
    
    NSArray *t = [touches allObjects];
    self.z = t[1];
    self.origin =  t[0];
        NSDictionary *end = @{
                              @"x": @(0),
                              @"y": @(0)
                              };
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:@"distanceDidChange" object:nil userInfo:@{
                                                                                            @"point": end,
                                                                                            @"speed": @(0)
                                                                                            }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *touchControls = [touches allObjects];
    
    if (touches.count != 2) {
        return;
    }
    
    CGPoint origin = [self.origin locationInView:self.view];
    CGPoint z = [self.z locationInView:self.view];
    
    double distance = [self distanceBetweenPoint1:origin point2:z];
    CGPoint center = [self centerForPoint1:origin point2:z];
    
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:@"distanceDidChange" object:nil userInfo:@{@"x": @(center.x),@"y": @(center.y), @"z": @(distance)}];
        
    NSLog(@"Here");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.origin = nil;
    self.z = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGPoint)centerForPoint1:(CGPoint)point1 point2:(CGPoint)point2 {
    return CGPointMake((point1.x + point2.x)/2.0, (point1.y + point2.y)/2.0);
}

- (double)distanceBetweenPoint1:(CGPoint)point1 point2:(CGPoint)point2 {
    return hypot(point1.x - point2.x, point1.y - point2.y);
}

@end
