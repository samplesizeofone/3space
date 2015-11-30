#import <Cocoa/Cocoa.h>

#import "Bridge.h"
#import "FigureViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong) Bridge *bridge;

@property (weak) IBOutlet FigureViewController *figureViewController;

@end

