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
    UITouch *touch = [touches anyObject];
    
    self.start = [touch locationInView:self.view];
    self.time = [touch timestamp];
    
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
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    CGPoint point2 = [touch previousLocationInView:self.view];
    
    
    
//    NSDictionary *start = @{
//                            @"x": @(self.start.x),
//                            @"y": @(self.start.y),
//                            };

    double time = [touch timestamp];

    double duration = time - self.time;
    
    
    self.time = time;
    
    
    NSDictionary *end = @{
                            @"x": @(point.x),
                            @"y": @(point.y),
                            };
    
    
    double speed = ([self distanceBetweenPoint1:self.start point2:point]/(duration + 1));
    speed *= 10;
    self.start = point;
    
    NSLog(@"%f %f %f", duration, [self distanceBetweenPoint1:self.start point2:point], speed);

    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:@"distanceDidChange" object:nil userInfo:@{
                                                                                        @"point": end,
                                                                                        @"speed": @(speed)
                                                                                        }];
    
    NSLog(@"Here %f", point.y);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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
