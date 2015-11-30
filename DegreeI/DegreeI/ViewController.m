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
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *touchControls = [touches allObjects];
    
    if (touches.count != 2) {
        return;
    }
    
    CGPoint point1 = [touchControls[0] locationInView:self.view];
    CGPoint point2 = [touchControls[1] locationInView:self.view];
    
    if (self.centerPoint.x == 0 && self.centerPoint.y == 0) {
        NSLog(@"reset");
        self.centerPoint = [self centerForPoint1:point1 point2:point2];
        self.startDistance = [self distanceBetweenPoint1:point1 point2:point2];
    }
    
    double distance = [self distanceBetweenPoint1:point1 point2:point2] - self.startDistance;
    CGPoint c = [self centerForPoint1:point1 point2:point2];
    double x = c.x - self.centerPoint.x;
    double y = self.centerPoint.y - c.y;
    NSLog(@"%f %f %f", x, y, distance);
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:@"distanceDidChange" object:nil userInfo:@{@"x": @(x),@"y": @(y), @"z": @(distance)}];
    
    self.centerPoint = [self centerForPoint1:point1 point2:point2];
    self.startDistance = [self distanceBetweenPoint1:point1 point2:point2];
    
    NSLog(@"Here");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.centerPoint = CGPointMake(0, 0);
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
