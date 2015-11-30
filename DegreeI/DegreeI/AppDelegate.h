//
//  AppDelegate.h
//  DegreeI
//
//  Created by Tyler Spaeth on 11/27/15.
//  Copyright © 2015 Tyler Spaeth. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Bridge.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong) Bridge *bridge;

@end

